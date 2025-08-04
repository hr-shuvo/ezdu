import { EmailProvider } from "../provider/emailProvider.ts";
import { EmailRenderer } from "./emailRenderer.ts";
import { EmailPayload } from "../../types/email.types.ts";

export class EmailService {
    constructor(private readonly emailProvider: EmailProvider,
                private readonly renderer: EmailRenderer) {
    }


    async sendEmailTemplate(payload: EmailPayload): Promise<void> {
        const {
            to,
            template,
            context,
            subject,
            attachments,
            cc,
            bcc,
            from,
            replyTo

        } = payload;

        const html = await this.renderer.render(template, context);


        if (!html) {
            throw new Error(`Email template of type ${template} not found`);
        }

        await this.emailProvider.sendEmail({
            to,
            subject,
            html,
            attachments,
            cc,
            bcc,
            from,
            replyTo
        })
    }


}