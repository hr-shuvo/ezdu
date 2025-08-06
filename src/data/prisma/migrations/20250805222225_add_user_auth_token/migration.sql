-- AlterTable
ALTER TABLE `UserAuthToken` MODIFY `verifyToken` VARCHAR(255) NOT NULL,
    MODIFY `resetToken` VARCHAR(255) NULL,
    MODIFY `loginToken` VARCHAR(255) NULL;
