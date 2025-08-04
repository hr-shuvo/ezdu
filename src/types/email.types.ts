export type EmailTemplateType =
    'verification' |
    'resetPassword' |
    'welcome' |
    'notification';

export interface EmailAttachment{
    filename: string;
    content: string | Buffer;
    contentType?: 'inline' | 'attachment';
}

export interface EmailPayload {
    to: string;
    subject: string;
    template: EmailTemplateType;
    context?: Record<string, any>;
    attachments?: EmailAttachment[];
    cc?: string[];
    bcc?: string[];
    from?: string;
    replyTo?: string;
}