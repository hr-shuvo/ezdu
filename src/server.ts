import express from 'express';
import * as dotenv from 'dotenv';
import cookieParser from 'cookie-parser';
import cors from 'cors';
import { connectDatabase, getDbHealth, registerShutdownHandlers } from "./data/config/db.ts";
import { scopePerRequest } from "awilix-express";
import { errorHandlerMiddleware } from "./middleware/errorHandlerMiddleware.ts";
import container from "./container.ts";
import applicationRoutes from "./routes/applicationRoutes.ts";
import { nowUtc } from "./utils/date.ts";

dotenv.config();



const app = express();

app.use(cookieParser());
app.use(express.json());
app.use(scopePerRequest(container))

const allowedOrigins = process.env.CLIENT_URL ? process.env.CLIENT_URL.split(",") : [];
app.use(
    cors({
        origin: allowedOrigins,
        credentials: true
    })
)


registerShutdownHandlers();


const PORT = process.env.PORT || 5000;


app.get('/', (req, res) => {
    res.json({
        message: 'Hello, Express with Prisma!',
        status: 'Server is running',
        timestamp: nowUtc()
    });
});
app.get('/api/health', getDbHealth);
app.use('/api/v1', applicationRoutes);
app.use((req, res) => {
    res.status(404).json({ error: 'route not found' });
});



// Global error handler
app.use(errorHandlerMiddleware);


async function startServer() {
    try {
        await connectDatabase();

        app.listen(PORT, () => {
            console.log(`🚀 -----------> Server is running on port ${PORT}`);
            console.log(`📊 -----------> Health check available at http://localhost:${PORT}/api/health`);
        });
    } catch (error) {
        console.error('Failed to start server:', error);
        process.exit(1);
    }
}

startServer().catch((error) => {
    console.error('Startup error:', error);
});



