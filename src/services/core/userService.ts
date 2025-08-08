import { UserRepository } from "../../repositories/core/userRepository.ts";
import { UserDto } from "../../domain/entities/user.ts";
import { NotFoundError } from "../../middleware/errorHandlerMiddleware.ts";
import { UserRole } from "@prisma/client";


export class UserService{
    constructor(private userRepository: UserRepository) {
    }

    async findByEmail(email: string) {
        try {
            return await this.userRepository.findByEmail(email);
        } catch (error) {
            console.error('Error finding user by email:', error);
            throw error;
        }
    }

    async findById(id: string)  {
        try {
            const response =  await this.userRepository.findById(id);

            if (!response) {
                throw new NotFoundError('User not found');
            }

            let user: UserDto;
            user = {
                id: response.id,
                name: response.name,
                username: response.username,
                email: response.email,
                avatar: response?.avatar,
                avatarPublicId: response.avatarPublicId,
                role: response.role,
                isActive: response.isActive,
                isVerified: response.isVerified,
                hasNotifications: response.hasNotifications
            };

            return user;
        } catch (error) {
            console.error('Error finding user by ID:', error);
            throw error;
        }
    }

    async getUser(id: string) {
        try {
            const response = await this.userRepository.getUser(id);

            if (!response) {
                throw new NotFoundError('User not found');
            }

            let user: UserDto;
            user = {
                id: response.id,
                name: response.name,
                username: response.username,
                email: response.email,
                avatar: response?.avatar,
                avatarPublicId: response.avatarPublicId,
                role: response.role,
                isActive: response.isActive,
                isVerified: response.isVerified,
                hasNotifications: response.hasNotifications
            };

            return user;
        } catch (error) {
            console.error('Error finding user by username:', error);
            throw error;
        }
    }

    async updateUser(userId: string, userModel: UserDto, role?: string) {

        try {
            const isSelfUpdate = userId === userModel.id;
            const isAuthorized = isSelfUpdate || this.IsAdmin(role!);

            if (!isAuthorized) {
                throw new Error('You are not authorized to update this user');
            }

            const existingUser = await this.userRepository.findById(userId);
            if (!existingUser) {
                throw new NotFoundError('User not found');
            }

            const modelToUpdate: UserDto = {
                name: userModel.name,
                username: userModel.username,
                email: userModel.email,
                avatar: userModel.avatar,
                avatarPublicId: userModel.avatarPublicId,
                hasNotifications: userModel.hasNotifications
            }

            if (this.IsAdmin(role!)) {
                modelToUpdate.email = userModel.email;
                modelToUpdate.role = userModel.role;
                modelToUpdate.isActive = userModel.isActive;
                modelToUpdate.isVerified = userModel.isVerified;
            }

            return await this.userRepository.update(userId, modelToUpdate);
        } catch (error) {
            console.error('Error updating user:', error);
            throw error;
        }

    }


    /**
     * Update user partial information like name, email, isVerified, etc.
     * @param userId - The ID of the user to update
     * @param userDto - Partial user data to update
     * @returns Updated user data
     */
    async updateUserPartial(userId: any, userDto: Partial<UserDto>) {
        try {
            return await this.userRepository.update(userId, userDto);
        } catch (error) {
            console.error('Error updating user:', error);
            throw error;
        }

    }














    // Private methods
    private  IsSuperAdmin = (role: string): boolean => {
        return role === UserRole.SUPER_ADMIN;
    }
    private IsAdmin = (role: string): boolean => {
        return role === UserRole.SUPER_ADMIN || role === UserRole.ADMIN;
    }
    private IsModerator = (role: string): boolean => {
        return role === UserRole.SUPER_ADMIN || role === UserRole.ADMIN || role === UserRole.MODERATOR;
    }

}