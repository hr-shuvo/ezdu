import { asClass, asValue, createContainer, InjectionMode } from "awilix";
import { prisma } from "./data/config/db.ts";



const container = createContainer({
    injectionMode: InjectionMode.CLASSIC,
});

container.register({
    prisma: asValue(prisma),



    // Registering Repositories
    // userRepository: asClass(UserRepository).scoped(),




    // Registering Services
    // authService: asClass(AuthService).scoped(),




    // Registering Controllers
    // authController:asClass(AuthController).scoped(),
});



export default container;