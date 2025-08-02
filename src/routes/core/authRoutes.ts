import { Router } from "express";
import container from "../../container.ts";
import { AuthController } from "../../controllers/authController.ts";


const router = Router()
const authController = container.resolve<AuthController>('authController');


router.post("/register", authController.register);
router.post("/login", authController.login);
router.post("/logout", authController.logout);


export default router;