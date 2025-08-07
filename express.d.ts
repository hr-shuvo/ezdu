import 'express';

declare global {
    namespace Express {
        interface Request {
            // customField?: string;
            user?: {
                userId: string;
                role: string;
            };
        }
    }
}
