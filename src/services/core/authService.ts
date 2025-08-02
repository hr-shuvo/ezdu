import { UserService } from "./userService.ts";
import { RegisterDto } from "../../domain/dtos/authDto.ts";
import { AuthRepository } from "../../repositories/core/authRepository.ts";
import { UserDto } from "../../domain/entities/user.ts";
import { Prisma } from "@prisma/client";
import { ComparePassword, HashPassword } from "../../utils/passwordUtls.ts";
import { BadRequestError, NotFoundError, UnauthorizedError } from "../../middleware/errorHandlerMiddleware.ts";
import { createJWT } from "../../utils/tokenUtils.ts";


export class AuthService {
    constructor(private readonly authRepository: AuthRepository,
                private readonly userService: UserService) {
    }

    async register(userData: RegisterDto) : Promise<UserDto> {
        const existingUser = await this.userService.findByEmail(userData.email);
        if (existingUser) {
            throw new BadRequestError('Email already exists');
        }

        const { password, firstName, lastName, ...rest } = userData;
        const hashedPassword = await HashPassword(password);

        const user: Prisma.UserCreateInput = {
            ...rest,
            username: userData.email,
            password: hashedPassword,
            name: `${firstName} ${lastName}`.trim(),
        }

        const result =  await this.authRepository.register(user);

        const userDto: UserDto = {
            id: result.id,
            email: result.email,
            username: result.username,
        }

        return userDto;
    }


    async login(loginDto: {email: string; password: string}) : Promise<string> {
        const user = await this.userService.findByEmail(loginDto.email);

        if (!user) {
            throw new NotFoundError('Invalid email or password');
        }

        const isPasswordValid = await ComparePassword(loginDto.password, user.password);

        if(!isPasswordValid){
            throw new UnauthorizedError('Invalid email or password');
        }

        const token = createJWT({userId: user.id, role: user.role});

        return token;
    }
}