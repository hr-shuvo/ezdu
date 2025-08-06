import { UserService } from "./userService.ts";
import { RegisterDto } from "../../domain/dtos/authDto.ts";
import { AuthRepository } from "../../repositories/core/authRepository.ts";
import { UserDto } from "../../domain/entities/user.ts";
import { Prisma } from "@prisma/client";
import { ComparePassword, HashPassword } from "../../utils/passwordUtls.ts";
import { BadRequestError, NotFoundError, UnauthorizedError } from "../../middleware/errorHandlerMiddleware.ts";
import { createJWT, decryptByCryptr } from "../../utils/tokenUtils.ts";
import { EmailService } from "../../shared/services/emailService.ts";
import { addUtc, nowUtc } from "../../utils/date.ts";
import { EmailPayload } from "../../types/email.types.ts";


export class AuthService {
    constructor(private readonly authRepository: AuthRepository,
                private readonly userService: UserService,
                private readonly emailService: EmailService
    ) {
    }

    async register(userData: RegisterDto): Promise<UserDto> {
        const existingUser = await this.userService.findByEmail(userData.email);
        if (existingUser) {
            throw new BadRequestError('Email already exists');
        }

        const {password, firstName, lastName, ...rest} = userData;
        const hashedPassword = await HashPassword(password);

        const user: Prisma.UserCreateInput = {
            ...rest,
            username: userData.email,
            password: hashedPassword,
            name: `${firstName} ${lastName}`.trim(),
        }

        const result = await this.authRepository.register(user);

        const userDto: UserDto = {
            id: result.id,
            email: result.email,
            username: result.username,
        }

        return userDto;
    }


    async login(loginDto: { email: string; password: string }): Promise<string> {
        const user = await this.userService.findByEmail(loginDto.email);

        if (!user) {
            throw new NotFoundError('Invalid email or password');
        }

        const isPasswordValid = await ComparePassword(loginDto.password, user.password);

        if (!isPasswordValid) {
            throw new UnauthorizedError('Invalid email or password');
        }

        return createJWT({userId: user.id, role: user.role});
    }


    // Placeholder for sending verification email
    async sendVerificationEmail(email: string) {
        if (!email) {
            throw new BadRequestError('Email is required');
        }

        const user = await this.userService.findByEmail(email);
        if (!user) {
            throw new NotFoundError('User not found');
        }

        let token = await this.authRepository.getAuthToken(user.id);
        if (!token) {
            const expiresAt = addUtc(nowUtc(), 10, 'minute');
            token = await this.authRepository.createAuthToken(user.id, 'verify', expiresAt);
        }

        const tokenEncryptedCode = token.verifyToken;
        const tokenCode = tokenEncryptedCode ? decryptByCryptr(tokenEncryptedCode) : null;

        if (!tokenCode) {
            throw new BadRequestError('Failed to generate verification token');
        }

        const emailContent: EmailPayload = {
            subject: 'Email Verification',
            template: 'verification',
            to: email,
            context:{
                name: user.name ?? user.username,
                verificationLink: `${process.env.APP_URL}/auth/verify?token=${tokenCode}`, // TODO: Update with actual verification link
                code: tokenCode,
                // tokenId: token.id,
                // tokenCreatedAt: token.createdAt.toISOString(),
                expiresAt: token.expiresAt.toISOString(),
            }
        };

        await this.emailService.sendEmail(emailContent);
    }
}