import { Router } from "express";
import authRoutes from "./core/authRoutes.ts";
import userRoutes from "./core/userRoutes.ts";
const router = Router()


router.use('/auth', authRoutes);
router.use('/users', userRoutes);
// router.use('/academy', authRoutes);
// router.use('/admission', authRoutes);
// router.use('/leaderboard', authRoutes);
// router.use('/blog', authRoutes);
router.use('/discussion', authRoutes);








export default router;