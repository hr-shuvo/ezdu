import { Router } from "express";
import container from "../../container.ts";
import { AuthController } from "../../controllers/authController.ts";


const router = Router()
const authController = container.resolve<AuthController>('authController');


router.post("/register", authController.register.bind(authController));


export default router;