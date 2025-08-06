import jwt from 'jsonwebtoken';
import Cryptr from 'cryptr';
import envConfig from "../data/config/env.ts";


const cryptr = new Cryptr(envConfig.ENCRYPTION_KEY);

export const createJWT = (payload:any):string => {
    // return token
    return jwt.sign(payload, envConfig.JWT.SECRET, {
        expiresIn: envConfig.JWT.EXPIRATION
    });
}

export const verifyJWT = (token:string) => {
    return jwt.verify(token, envConfig.JWT.SECRET);
}

export const encryptByCryptr = (token:string):string => {

    return cryptr.encrypt(token);
}

export const decryptByCryptr = (encryptedToken:string):string => {

    try {
        return cryptr.decrypt(encryptedToken);
    } catch (error) {
        console.error('Error decrypting token:', error);
        throw new Error('Invalid token');
    }
}