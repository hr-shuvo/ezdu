

export interface UserDto {
    id?: string;
    name?: string;
    username?: string;
    email?: string;
    avatar?: string;
    avatarPublicId?: string;
    role?: 'SUPER_ADMIN' | 'ADMIN' | 'MODERATOR' | 'USER';
    isActive?: boolean;
    isVerified?: boolean;
    hasNotifications?: boolean;


}