import { Prisma, PrismaClient } from "@prisma/client";
import { nowUtc } from "../../utils/date.ts";
import { encryptByCryptr } from "../../utils/tokenUtils.ts";


export class AuthRepository {

    constructor(private prisma: PrismaClient) {
    }

    async register(userData:Prisma.UserCreateInput) {

        try {
            return await this.prisma.user.create({
                data: userData,
            });
        } catch (e) {
            console.error('Error creating user:', e);
            throw e;
        }
    }








    // handle token creation and validation
    /**
     * Get the auth token for a user
     * @param userId - The ID of the user
     * @returns The auth token for the user if it exists and is not expired, otherwise null
     * @throws Error if there is an issue retrieving the token from the database
     */
    async getAuthToken(userId: string){
        try{
            return await this.prisma.userAuthToken.findUnique({
                where: {
                    userId: userId,
                    expiresAt : {
                        gte : nowUtc()
                    }
                }
            });
        }
        catch (e) {
            console.error('Error getting auth token:', e);
            throw e;
        }
    }

    async createAuthToken(userId: string, type: 'verify' | 'reset' | 'login', expiresAt: Date) {
        try {
            await this.prisma.userAuthToken.deleteMany({
                where: {
                    userId: userId
                }
            });

            const code = Math.floor(1000 + Math.random() * 9000).toString();
            const token = encryptByCryptr(code);

            if(type === 'verify') {
                return await this.prisma.userAuthToken.create({
                    data: {
                        userId: userId,
                        verifyToken: token,
                        expiresAt: expiresAt,
                    }
                })
            }
            else if(type === 'reset') {
                return await this.prisma.userAuthToken.create({
                    data: {
                        userId: userId,
                        verifyToken:'',
                        resetToken: token,
                        expiresAt: expiresAt,
                    }
                })
            } else if(type === 'login') {
                return await this.prisma.userAuthToken.create({
                    data: {
                        userId: userId,
                        verifyToken:'',
                        loginToken: token,
                        expiresAt: expiresAt,
                    }
                })
            } else {
                throw new Error('Invalid token type');
            }
        } catch (e) {
            console.error('Error creating auth token:', e);
            throw e;
        }
    }

}