import { PrismaClient } from "@prisma/client";
import {Request, Response} from "express";


const prisma = new PrismaClient();


async function connectDatabase() {
    try {
        await prisma.$connect();
        console.log('Connected to the database successfully');
    } catch (error) {
        console.error('Error connecting to the database:', error);
        process.exit(1);
    }
}

async function shutdown() {
    try {
        await prisma.$disconnect();
        console.log('Database connection closed');
    } catch (error) {
        console.error('Error during database disconnect:', error);
    } finally {
        process.exit(0);
    }
}

function registerShutdownHandlers() {
    process.on('SIGINT', shutdown);
    process.on('SIGTERM', shutdown);
}

const getDbHealth = async (req:Request, res:Response) => {
    try {
        await prisma.$queryRaw`SELECT 1`;
        res.json({
            status: 'healthy',
            database: 'connected',
            timestamp: new Date().toISOString()
        });
    } catch (error) {
        res.status(500).json({
            status: 'unhealthy',
            database: 'disconnected',
            error: error instanceof Error ? error.message : 'Unknown error',
            timestamp: new Date().toISOString()
        });
    }
}

export { prisma, connectDatabase, registerShutdownHandlers, getDbHealth };