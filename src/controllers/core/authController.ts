import { Request, Response, NextFunction } from 'express';
import { AuthService } from "../../services/core/authService.ts";
import { BadRequestError } from "../../middleware/errorHandlerMiddleware.ts";
import { RegisterDto } from "../../domain/dtos/authDto.ts";
import asyncHandler from "express-async-handler";


export class AuthController {
    constructor(private authService: AuthService) {
    }

    register = async (req: Request, res: Response, next: NextFunction) => {
        const {email, password, firstName, lastName} = req.body;

        if (!email || !password) {
            throw new BadRequestError('Email and password are required');
        }

        try {
            const registerDto: RegisterDto = {
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

    login = async (req: Request, res: Response, next: NextFunction) => {
        const {email, password} = req.body;

        if (!email || !password) {
            throw new BadRequestError('Email and password are required');
        }

        try {
            const loginDto = {
                email,
                password
            }

            const token = await this.authService.login(loginDto);

            res.cookie('token', token, {
                path: '/',
                httpOnly: true,
                expires: new Date(Date.now() + 1000 * 86400 * 7), // 7 day
                sameSite: 'none',
                secure: true,
                ...(process.env.NODE_ENV === 'production' && {domain: '.ezduonline.com'})
            })

            return res.status(200).json({token});
        } catch (error) {
            next(error);
        }
    }

    logout = async (req: Request, res: Response, next: NextFunction) => {
        try {
            res.cookie('token', '', {
                path: '/',
                httpOnly: true,
                // expires: new Date(0),
                maxAge: 0,
                sameSite: 'none',
                secure: true,
                ...(process.env.NODE_ENV === 'production' && {domain: '.ezduonline.com'})
            });

            res.status(200).json({message: 'Logged out successfully'});
        } catch (error) {
            next(error);
        }
    }

    sendVerificationEmail = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        try {

            const {email} = req.params;
            await this.authService.sendVerificationEmail(email);

            res.status(200).json({message: 'Verification email sent successfully'});
        } catch (error) {
            next(error);
        }
    });

    verifyVerificationCode = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const {email, code} = req.body;

        await this.authService.verifyVerificationCode(email, code);

        res.status(200).json({message: 'Verification successful'});
    });


}