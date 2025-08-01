import { asClass, asValue, createContainer, InjectionMode } from "awilix";
import { prisma } from "./data/config/db.ts";
import { AuthController } from "./controllers/authController.ts";
import { AuthService } from "./services/core/authService.ts";
import { UserRepository } from "./repositories/core/userRepository.ts";
import { AuthRepository } from "./repositories/core/authRepository.ts";
import { UserService } from "./services/core/userService.ts";
import { UserController } from "./controllers/userController.ts";



const container = createContainer({
    injectionMode: InjectionMode.CLASSIC,
});

container.register({
    prisma: asValue(prisma),



    // Registering Repositories
    authRepository: asClass(AuthRepository).scoped(),
    userRepository: asClass(UserRepository).scoped(),




    // Registering Services
    authService: asClass(AuthService).scoped(),
    userService: asClass(UserService).scoped(),




    // Registering Controllers
    authController:asClass(AuthController).scoped(),
    userController: asClass(UserController).scoped()
});



export default container;