const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

(async () => {
    const browser = await puppeteer.launch({ headless: "new" });

    const directoryPath = path.join(__dirname, 'rendered');
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
            await page.pdf({ path: 'rendered/prompt.pdf', format: 'A4', scale: 0.8, margin: margins });
            console.log(`Saved ${file}.pdf`);
            await page.close();
        }

        await browser.close();
    });
})();
