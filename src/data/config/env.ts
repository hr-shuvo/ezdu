import dotenv from 'dotenv';

dotenv.config();


interface EnvConfig {
    PORT: number;
    DATABASE_URL: string;
    JWT :{
        SECRET: string;
        EXPIRATION: '1d' | '2d' | '7d' | '30d' | '365d';
    }
    NODE_ENV: 'development' | 'production' | 'test';
    EMAIL:{
        MAILJET:{
            API_KEY: string;
            API_SECRET: string;
            SENDER_EMAIL: string;
            SENDER_NAME: string;
        },
        SENDGRID:{
            API_KEY: string;
            SENDER_EMAIL: string;
            SENDER_NAME: string;
        },
        SMTP:{
            HOST: string;
            PORT: number;
            USER: string;
            PASS: string;
        }
    },

    CLOUDINARY: {
        CLOUD_NAME: string;
        API_KEY: string;
        API_SECRET: string;
    },
    AWS: {
        ACCESS_KEY_ID: string;
        SECRET_ACCESS_KEY: string;
        REGION: string;
        BUCKET_NAME: string;
    },

    PAYMENT: {
        PAYPAL: {
            CLIENT_ID: string;
            SECRET: string;
        },
        STRIPE: {
            SECRET_KEY: string;
            PUBLISHABLE_KEY: string;
        }
    },


}

const envConfig: EnvConfig = {
    PORT: parseInt(process.env.PORT || '5000', 10),
    DATABASE_URL: process.env.DATABASE_URL || '',
    JWT: {
        SECRET: process.env.JWT_SECRET || 'super-secret-key',
        EXPIRATION: process.env.JWT_EXPIRATION as '1d' | '2d' | '7d' | '30d' | '365d' || '1d',
    },
    NODE_ENV: process.env.NODE_ENV as 'development' | 'production' | 'test' || 'development',

    EMAIL: {
        MAILJET: {
            API_KEY: process.env.MAILJET_API_KEY || '',
            API_SECRET: process.env.MAILJET_API_SECRET || '',
            SENDER_EMAIL: process.env.MAILJET_SENDER_EMAIL || '',
            SENDER_NAME: process.env.MAILJET_SENDER_NAME || '',
        },
        SENDGRID: {
            API_KEY: process.env.SENDGRID_API_KEY || '',
            SENDER_EMAIL: process.env.SENDGRID_SENDER_EMAIL || '',
            SENDER_NAME: process.env.SENDGRID_SENDER_NAME || '',
        },
        SMTP: {
            HOST: process.env.SMTP_HOST || '',
            PORT: parseInt(process.env.SMTP_PORT || '587', 10),
            USER: process.env.SMTP_USER || '',
            PASS: process.env.SMTP_PASS || '',
        }
    },

    CLOUDINARY: {
        CLOUD_NAME: process.env.CLOUDINARY_CLOUD_NAME || '',
        API_KEY: process.env.CLOUDINARY_API_KEY || '',
        API_SECRET: process.env.CLOUDINARY_API_SECRET || '',
    },

    AWS: {
        ACCESS_KEY_ID: process.env.AWS_ACCESS_KEY_ID || '',
        SECRET_ACCESS_KEY: process.env.AWS_SECRET_ACCESS_KEY || '',
        REGION: process.env.AWS_REGION || 'us-east-1',
        BUCKET_NAME: process.env.AWS_BUCKET_NAME || '',
    },

    PAYMENT: {
        PAYPAL: {
            CLIENT_ID: process.env.PAYPAL_CLIENT_ID || '',
            SECRET: process.env.PAYPAL_SECRET || '',
        },
        STRIPE: {
            SECRET_KEY: process.env.STRIPE_SECRET_KEY || '',
            PUBLISHABLE_KEY: process.env.STRIPE_PUBLISHABLE_KEY || '',
        }
    }


};

export default envConfig;
