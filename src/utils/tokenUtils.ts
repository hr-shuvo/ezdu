import jwt, { JwtPayload } from 'jsonwebtoken';
import Cryptr from 'cryptr';
import envConfig from "../data/config/env.ts";


const cryptr = new Cryptr(envConfig.ENCRYPTION_KEY);

interface TokenPayload extends JwtPayload {
    userId: string;
    role: string;
}

export const createJWT = (payload: TokenPayload): string => {
    // return token
    return jwt.sign(payload, envConfig.JWT.SECRET, {
        expiresIn: envConfig.JWT.EXPIRATION
    });
}

export const verifyJWT = (token: string): TokenPayload => {
    const result = jwt.verify(token, envConfig.JWT.SECRET);

    return result as TokenPayload;
}

export const encryptByCryptr = (token: string): string => {

    return cryptr.encrypt(token);
}

export const decryptByCryptr = (encryptedToken: string): string => {

    try {
        return cryptr.decrypt(encryptedToken);
    } catch (error) {
        console.error('Error decrypting token:', error);
        throw new Error('Invalid token');
    }
}