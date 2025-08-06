-- CreateTable
CREATE TABLE `UserAuthToken` (
    `id` VARCHAR(191) NOT NULL,
    `userId` VARCHAR(191) NOT NULL,
    `verifyToken` VARCHAR(191) NOT NULL,
    `resetToken` VARCHAR(191) NULL,
    `loginToken` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `expiresAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `UserAuthToken_userId_key`(`userId`),
    UNIQUE INDEX `UserAuthToken_verifyToken_key`(`verifyToken`),
    UNIQUE INDEX `UserAuthToken_resetToken_key`(`resetToken`),
    UNIQUE INDEX `UserAuthToken_loginToken_key`(`loginToken`),
    INDEX `UserAuthToken_userId_idx`(`userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE INDEX `User_username_idx` ON `User`(`username`);

-- CreateIndex
CREATE INDEX `User_email_idx` ON `User`(`email`);
