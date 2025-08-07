import { PrismaClient, Prisma } from "@prisma/client";


export class UserRepository {

    constructor(private prisma: PrismaClient) {
    }

    async findByEmail(email: string) {
        try {
            return await this.prisma.user.findUnique({
                where: {email},
            });
        } catch (error) {
            console.error('Error finding user by email:', error);
            throw error;
        }
    }

    async findByUsername(uname: string) {
        try {
            return await this.prisma.user.findUnique({
                where: {username: uname},
            });
        } catch (error) {
            console.error('Error finding user by username:', error);
            throw error;
        }
    }

    async findById(id: string) {
        try {
            return await this.prisma.user.findUnique({
                where: {id},
            });
        } catch (error) {
            console.error('Error finding user by ID:', error);
            throw error;
        }
    }

    /**
     * Retrieves a user from the database by matching the given value
     * against the user's ID, username, or email.
     *
     * @param id - A string that could be the user's ID, username, or email.
     * @returns The matched user object if found, or `null` if no match exists.
     * @throws Re-throws any unexpected Prisma errors during the query.
     */
    async getUser(id: string) {
        try {
            return await this.prisma.user.findFirst({
                where:{
                    OR:[
                        {id},
                        {username: id},
                        {email: id}
                    ]
                }
            });
        } catch (error) {
            console.error('Error getting user:', error);
            throw error;
        }
    }


    // async update(user: PrismaClient) {
    // }

    async update(userId: string, data: Prisma.UserUpdateInput) {
        try {
            return await this.prisma.user.update({
                where: {id: userId},
                data,
            });
        } catch (error) {
            console.error('Error updating user:', error);
            throw error;
        }
    }


}