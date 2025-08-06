import { UserRepository } from "../../repositories/core/userRepository.ts";


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













}