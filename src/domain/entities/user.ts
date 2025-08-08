import { UserRole } from "@prisma/client";


export interface UserDto {
    id?: string;
    name?: string | null;
    username?: string;
    email: string;
    avatar?: string | null;
    avatarPublicId?: string | null;
    role?: UserRole
    isActive?: boolean;
    isVerified?: boolean;
    hasNotifications?: boolean;


}