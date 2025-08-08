import { Router } from "express";
import { authenticateUser } from "../../middleware/authMiddleware.ts";
import { UserController } from "../../controllers/core/userController.ts";
import container from "../../container.ts";

const router = Router();
const userController = container.resolve<UserController>("userController");


router.get("/", userController.loadUser);
router.get("/me", authenticateUser, userController.getCurrentUser);
router.put("/me", authenticateUser, userController.updateCurrentUser);
// router.delete("/me", authenticateUser, userController.deleteCurrentUser);

// router.get("/me/notifications", getUserNotifications);
// router.get("/me/notifications/read", markAllNotificationsAsRead);

router.put("/update", authenticateUser, userController.updateUser);
router.get("/:id", userController.getUser); // always use later after static routes
// router.delete("/delete/:id", authenticateUser, userController.deleteUser);


export default router;