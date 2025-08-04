import path from "node:path";
import * as fs from "node:fs";

export class EmailRenderer{
    private partialLoaded: boolean = false;



    private loadPartials(){
        if (this.partialLoaded) return;

        const basePath = path.join(__dirname, '../templates/emails/layouts/base.hbs');
        const baseContent = fs.readFileSync(basePath, 'utf8');

        Handlebars.registerPartial('base', baseContent);

        this.partialLoaded = true;
    }

    // note: Template names should match the file names in the templates/emails directory
    // e.g., verification.hbs, resetPassword.hbs, welcome.hbs, notification
    async render(template: string, context: Record<string, any> = {}): Promise<string> {
        this.loadPartials();

        const templatePath = path.join(__dirname, '../templates/emails', `${template}.hbs`);

        if (!fs.existsSync(templatePath)) {
            throw new Error(`Template ${template} not found`);
        }

        const templateContent = fs.readFileSync(templatePath, 'utf8');

        const compiledTemplate = Handlebars.compile(templateContent);

        return compiledTemplate(context);
    }
}