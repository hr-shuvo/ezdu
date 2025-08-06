import nodemailer from 'nodemailer';
import envConfig from "../../data/config/env.ts";
import { BadRequestError } from "../../middleware/errorHandlerMiddleware.ts";

interface SendEmailOptions {
    to: string;
    subject: string;
    html: string;
    cc?: string[];
    bcc?: string[];
    from?: string;
    replyTo?: string;
    attachments?: { filename: string; content: string | Buffer; contentType?: 'inline' | 'attachment' }[];

}

export class EmailProvider{
    private transporter: nodemailer.Transporter = nodemailer.createTransport({
        host: envConfig.EMAIL.MAILJET.HOST,
        port: envConfig.EMAIL.SMTP.PORT,
        secure: envConfig.EMAIL.SMTP.SECURE, // true for 465, false for other ports
        auth: {
            user: envConfig.EMAIL.MAILJET.API_KEY || '', // SMTP username / email / API key
            pass: envConfig.EMAIL.MAILJET.API_SECRET || '' // SMTP password / app password / API secret
        },
    });




    async sendEmail(options: SendEmailOptions): Promise<void> {
        const mailOptions: nodemailer.SendMailOptions = {
            from: options.from ?? envConfig.EMAIL.MAILJET.SENDER_EMAIL,
            to: options.to,
            subject: options.subject,
            html: options.html,
            cc: options.cc?.join(', '),
            bcc: options.bcc?.join(', '),
            replyTo: options.replyTo ?? envConfig.EMAIL.MAILJET.NO_REPLY_EMAIL,
            attachments: options.attachments?.map(att => ({
                filename: att.filename,
                content: att.content,
                contentType: att.contentType
            }))
        };

        try {
            await this.transporter.sendMail(mailOptions);
        } catch (error) {
            console.error('Error sending email:', error);
            throw new BadRequestError('Failed to send email');
        }
    }
}