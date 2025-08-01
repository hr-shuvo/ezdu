import { UserService } from "./userService.ts";
import { RegisterDto } from "../../domain/dtos/authDto.ts";
import { AuthRepository } from "../../repositories/core/authRepository.ts";
import { UserDto } from "../../domain/entities/user.ts";
import { Prisma } from "@prisma/client";
import { HashPassword } from "../../utils/passwordUtls.ts";
import { BadRequestError } from "../../middleware/errorHandlerMiddleware.ts";


export class AuthService {
    constructor(private readonly authRepository: AuthRepository,
                private readonly userService: UserService) {
    }

    async register(userData: RegisterDto) : Promise<any> {
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

        console.log(user)

        const result =  await this.authRepository.register(user);

        const userDto: UserDto = {
            id: result.id,
            email: result.email,
            username: result.username,
        }

        return userDto;
    }


}