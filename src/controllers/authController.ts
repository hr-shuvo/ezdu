import { Request, Response, NextFunction } from 'express';
import { AuthService } from "../services/core/authService.ts";
import { BadRequestError } from "../middleware/errorHandlerMiddleware.ts";
import { RegisterDto } from "../domain/dtos/authDto.ts";


export class AuthController {
    constructor(private authService: AuthService) {
    }

    async register(req: Request, res: Response, next: NextFunction){
        const { email, password, firstName, lastName } = req.body;

        if (!email || !password) {
            throw new BadRequestError('Email and password are required');
        }

        try {
            const registerDto : RegisterDto = {
                email,
                password,
                firstName: firstName || '',
                lastName: lastName || ''
            }

            const user = await this.authService.register(registerDto);

            return res.status(201).json(user);
        } catch (error) {
            next(error);
        }
    }
}