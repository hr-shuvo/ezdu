import express from 'express';
import * as dotenv from 'dotenv';
import { connectDatabase } from "./infrastructure/data/dbConfig.ts";

dotenv.config();



const app = express();

app.use(express.json());




const PORT = process.env.PORT || 5000;





app.get('/', (req, res) => {
    res.json({
        message: 'Hello, Express with Prisma!',
        status: 'Server is running',
        timestamp: new Date().toISOString()
    });
});



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



