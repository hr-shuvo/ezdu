import { UserRepository } from "../../repositories/core/userRepository.ts";
import { UserDto } from "../../domain/entities/user.ts";
import { NotFoundError } from "../../middleware/errorHandlerMiddleware.ts";


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














}