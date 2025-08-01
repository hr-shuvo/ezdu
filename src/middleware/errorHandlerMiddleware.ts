import { Request, Response, NextFunction } from 'express';

export class AppError extends Error {
    statusCode: number;

    constructor(message: string, statusCode: number) {
        super(message);
        this.statusCode = statusCode;
        this.name = 'AppError';
        Error.captureStackTrace(this, this.constructor);
    }
}

export class BadRequestError extends AppError {
    constructor(message = 'Bad Request') {
        super(message, 400);
        this.name = 'BadRequestError';
    }
}

export class NotFoundError extends AppError {
    constructor(message = 'Not Found') {
        super(message, 404);
        this.name = 'NotFoundError';
    }
}

export class UnauthorizedError extends AppError {
    constructor(message = 'Unauthorized') {
        super(message, 401);
        this.name = 'UnauthorizedError';
    }
}


export const errorHandlerMiddleware = (err: unknown, req: Request, res: Response, next: NextFunction) => {
    console.error(`[ERROR]`, err);

    let statusCode = 500;
    let message = 'Something went wrong';

    const prismaError = parsePrismaError(err);
    if (prismaError) {
        statusCode = prismaError.statusCode;
        message = prismaError.message;
    } else if (err instanceof AppError) {
        statusCode = err.statusCode;
        message = err.message;
    } else if (err instanceof Error) {
        message = err.message;
    }

    res.status(statusCode).json({
        statusCode,
        error: message,
    });

}

const parsePrismaError = (error: any) => {
    // console.log(JSON.stringify(error, null, 2));
    if (!isPrismaError(error)) return null;

    const target = error.meta?.target;
    let fields = '';

    if (Array.isArray(target)) {
        fields = target.join(', ');
    } else if (typeof target === 'string') {
        fields = target;
    } else {
        fields = 'unknown field';
    }

    switch (error.code) {
        case 'P2000':
            return new BadRequestError('Value too long for column');
        case 'P2002':
            return new BadRequestError(`Duplicate field(s): ${fields}`);
        case 'P2025':
            return new NotFoundError('Record not found');
        default:
            return null;
    }

}

const isPrismaError = (error: any): boolean => {
    return error?.name === 'PrismaClientKnownRequestError' && typeof error.code === 'string';
}