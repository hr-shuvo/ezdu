import { asClass, asValue, createContainer, InjectionMode } from "awilix";
import { prisma } from "./data/config/db.ts";
import { AuthController } from "./controllers/core/authController.ts";
import { AuthService } from "./services/core/authService.ts";
import { UserRepository } from "./repositories/core/userRepository.ts";
import { AuthRepository } from "./repositories/core/authRepository.ts";
import { UserService } from "./services/core/userService.ts";
import { UserController } from "./controllers/core/userController.ts";
import { EmailService } from "./shared/services/emailService.ts";
import { EmailProvider } from "./shared/provider/emailProvider.ts";



const container = createContainer({
    injectionMode: InjectionMode.CLASSIC,
});

container.register({
    prisma: asValue(prisma),

    // Registering Providers or Dependencies

    emailProvider: asClass(EmailProvider).scoped(),



    // Registering Repositories
    authRepository: asClass(AuthRepository).scoped(),
    userRepository: asClass(UserRepository).scoped(),





    // Registering Services
    authService: asClass(AuthService).scoped(),
    userService: asClass(UserService).scoped(),
    emailService: asClass(EmailService).singleton(),




    // Registering Controllers
    authController:asClass(AuthController).scoped(),
    userController: asClass(UserController).scoped()
});



export default container;