import { EmailProvider } from "../provider/emailProvider.ts";
import Handlebars from 'handlebars';
import { EmailPayload } from "../../types/email.types.ts";
import path from "node:path";
import fs from "node:fs";
import { fileURLToPath } from "node:url";

export class EmailService {
    private partialLoaded: boolean = false;
    __filename = fileURLToPath(import.meta.url);
    __dirname = path.dirname(this.__filename);


    constructor(private readonly emailProvider: EmailProvider) {
    }


    async sendEmail(payload: EmailPayload): Promise<void> {
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

        // const html = await this.renderer.render(template, context);
        const html = await this.render(template, context);

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








    private loadPartials(){
        if (this.partialLoaded) return;

        const basePath = path.join(this.__dirname, '../templates/emails/layouts/base.hbs');
        const baseContent = fs.readFileSync(basePath, 'utf8');

        Handlebars.registerPartial('base', baseContent);

        this.partialLoaded = true;
    }

    private async render(template: string, context: Record<string, any> = {}): Promise<string> {
        this.loadPartials();

        const templatePath = path.join(this.__dirname, '../templates/emails', `${template}.hbs`);

        if (!fs.existsSync(templatePath)) {
            throw new Error(`Template ${template} not found`);
        }

        const templateContent = fs.readFileSync(templatePath, 'utf8');

        const compiledTemplate = Handlebars.compile(templateContent);
        const html = compiledTemplate(context);

        return html
    }
}