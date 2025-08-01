import * as express from 'express-serve-static-core';

declare global {
    namespace Express {
        interface Request {
            customField?: string; // Example of adding a custom field to the Request object
        }
    }
}
