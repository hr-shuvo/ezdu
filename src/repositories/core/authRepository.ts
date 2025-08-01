import { Prisma, PrismaClient } from "@prisma/client";


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

}