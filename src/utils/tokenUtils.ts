import jwt from 'jsonwebtoken';
import envConfig from "../data/config/env.ts";

export const createJWT = (payload:any):string => {
    const token = jwt.sign(payload, envConfig.JWT.SECRET, {
        expiresIn: envConfig.JWT.EXPIRATION
    });


    return token;
}

export const verifyJWT = (token:string) => {
    return jwt.verify(token, envConfig.JWT.SECRET);
}