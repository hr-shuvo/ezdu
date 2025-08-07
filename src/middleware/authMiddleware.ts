import { Request, Response, NextFunction } from 'express';
import { UnauthorizedError } from "./errorHandlerMiddleware.ts";
import { verifyJWT } from "../utils/tokenUtils.ts";

export const authenticateUser = (req: Request, res:Response, next:NextFunction) => {
    const {token} = req.cookies;

    if (!token) {
        throw new UnauthorizedError('you need to login');
    }

    try{
        const { userId, role } = verifyJWT(token);

        console.log('Auth (jwt) verification successful:', userId, role);

        req.user = {
            id: userId,
            role: role
        };
        next();
    }
    catch (error) {
        console.error('Auth (jwt) verification failed:', error);
        throw new UnauthorizedError('you need to login');
    }

}