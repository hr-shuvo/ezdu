import 'express';

declare global {
    namespace Express {
        interface Request {
            // customField?: string;
            user?: {
                id: string;
                role: string;
            };
        }
    }
}
