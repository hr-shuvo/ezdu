import { NextFunction, Request, Response } from "express";
import asyncHandler from 'express-async-handler';
import { UserService } from "../../services/core/userService.ts";
import { UnauthorizedError } from "../../middleware/errorHandlerMiddleware.ts";


export class UserController {
    constructor(private userService: UserService) {
    }

    loadUser = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        throw new Error("Method not implemented.");
    })

    getCurrentUser = asyncHandler(async (req: Request, res: Response) => {
        const {userId} = req.user!;

        if (!userId) {
            throw new UnauthorizedError("You need to be logged in");
        }

        const user = await this.userService.findById(userId);

        res.status(200).json(user);
    });

    updateCurrentUser = asyncHandler(async (req: Request, res: Response) => {
        throw new Error("Method not implemented.");
    });

    deleteCurrentUser = asyncHandler(async (req: Request, res: Response) => {
        throw new Error("Method not implemented.");
    });

    getUser = asyncHandler(async (req: Request, res: Response) => {
        throw new Error("Method not implemented.");
    });

    updateUser = asyncHandler(async (req: Request, res: Response) => {
        throw new Error("Method not implemented.");
    });

    deleteUser = asyncHandler(async (req: Request, res: Response) => {
        throw new Error("Method not implemented.");
    });


}