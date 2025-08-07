

export interface UserDto {
    id?: string;
    name?: string | null;
    username?: string;
    email: string;
    avatar?: string | null;
    avatarPublicId?: string | null;
    role?: 'SUPER_ADMIN' | 'ADMIN' | 'MODERATOR' | 'USER';
    isActive?: boolean;
    isVerified?: boolean;
    hasNotifications?: boolean;


}