const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

(async () => {
    const browser = await puppeteer.launch({ headless: "new" });
    const rendered_folder = "rendered";

    const directoryPath = path.join(__dirname, rendered_folder);
    fs.readdir(directoryPath, async (err, files) => {
        if (err) {
            console.error('Error reading directory ', err);
            process.exit(1);
        }

        const htmlFiles = files.filter(file => file.endsWith('.html'));

        for (const file of htmlFiles) {
            const absolutePath = path.join(directoryPath, file);
            const page = await browser.newPage();

            console.log('Printing', absolutePath);

            await page.goto(`file://${absolutePath}`, { waitUntil: 'networkidle2' });

            const margins = { bottom: 20, top: 20, left: 20, right: 20 }
            const pdf_path = path.join(rendered_folder, file.replace("html", "pdf"))
            await page.pdf({ path: pdf_path, format: 'A4', margin: margins, printBackground: true });
            console.log(`Saved ${pdf_path}`);

            await page.close();
        }

        await browser.close();
    });
})();
