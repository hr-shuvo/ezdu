import { PrismaClient } from "@prisma/client";


export class UserRepository {

    constructor(private prisma: PrismaClient) {
    }

    async findByEmail(email: string) {
        try {
            return await this.prisma.user.findUnique({
                where: { email },
            });
        } catch (error) {
            console.error('Error finding user by email:', error);
            throw error;
        }
    }

    async findByUsername(uname: string) {
        try {
            return await this.prisma.user.findUnique({
                where: { username: uname },
            });
        } catch (error) {
            console.error('Error finding user by username:', error);
            throw error;
        }
    }

    async findById(id: string) {
        try {
            return await this.prisma.user.findUnique({
                where: { id },
            });
        } catch (error) {
            console.error('Error finding user by ID:', error);
            throw error;
        }
    }



    async update(user: PrismaClient) {}


}