import { NextFunction, Request, Response } from "express";
import { UserService } from "../services/core/userService.ts";


export class UserController {
    constructor(private userService: UserService) {
    }

    loadUser = async (req: Request, res: Response, next: NextFunction) => {
        throw new Error("Method not implemented.");
    }

    getCurrentUser = async (req: Request, res: Response, next: NextFunction) => {
        return res.status(200).json({
            name: "John Doe",
            email: "john@email.com",
            role: "user",
            id: "12345",
            createdAt: new Date()

        });
    }

    // updateCurrentUser = async (req: Request, res: Response, next: NextFunction) => {
    //     throw new Error("Method not implemented.");
    // }
    // deleteCurrentUser = async (req: Request, res: Response, next: NextFunction) => {
    //     throw new Error("Method not implemented.");
    // }
    // getUser = async (req: Request, res: Response, next: NextFunction) => {
    //     throw new Error("Method not implemented.");
    // }
    // updateUser = async (req: Request, res: Response, next: NextFunction) => {
    //     throw new Error("Method not implemented.");
    // }
    // deleteUser = async (req: Request, res: Response, next: NextFunction) => {
    //     throw new Error("Method not implemented.");
    // }


}