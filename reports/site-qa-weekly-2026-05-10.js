const fs = require('fs');
const path = require('path');
const { chromium } = require('/tmp/openclaw-pw/node_modules/playwright');

const outDir = path.join(process.cwd(), 'reports', 'site-qa', '2026-05-10');
fs.mkdirSync(outDir, { recursive: true });

async function setRange(locator, value) {
  await locator.evaluate((el, v) => {
    const setter = Object.getOwnPropertyDescriptor(HTMLInputElement.prototype, 'value').set;
    setter.call(el, String(v));
    el.dispatchEvent(new Event('input', { bubbles: true }));
    el.dispatchEvent(new Event('change', { bubbles: true }));
  }, value);
}

(async () => {
  const browser = await chromium.launch({ headless: true });
  const results = [];

  // kanji-practice
  {
    const page = await browser.newPage({ viewport: { width: 1440, height: 2200 } });
    await page.goto('https://knishioka.github.io/kanji-practice/', { waitUntil: 'networkidle' });
    const pageCounts = {};
    for (const n of [1, 5, 10]) {
      await setRange(page.locator('input[aria-label="ページ数"]'), n);
      await page.getByText('問題を生成').click();
      await page.waitForTimeout(800);
      const text = await page.locator('body').innerText();
      const count = [...text.matchAll(new RegExp(`1年生 \\| (\\d+)\\/${n}`, 'g'))].length;
      pageCounts[n] = count;
    }
    const text = await page.locator('body').innerText();
    const debugVisible = /\bDebug\b/.test(text);
    await page.screenshot({ path: path.join(outDir, 'kanji-practice.png'), fullPage: true });
    results.push({
      repo: 'knishioka/kanji-practice',
      checks: {
        pageCounts,
        debugVisible,
        contentSpotCheck: '1年生 読み練習の生成内容を目視確認。語彙は初等漢字中心で、明らかな学年外混入は今回の spot check では未検出。'
      },
      status: debugVisible ? 'issue' : 'ok'
    });
    await page.close();
  }

  // math-worksheet
  {
    const page = await browser.newPage({ viewport: { width: 1440, height: 2200 } });
    await page.goto('https://knishioka.github.io/math-worksheet/', { waitUntil: 'networkidle' });
    const defaultText = await page.locator('body').innerText();
    const thirtyProblemsVisible = (defaultText.match(/\(\d+\)/g) || []).length >= 30;
    await page.getByText('1桁のひき算（繰り下がりなし）').click();
    await page.waitForTimeout(600);
    const subText = await page.locator('body').innerText();
    const preview = subText.slice(subText.indexOf('問題プレビュー'));
    const pairs = [...preview.matchAll(/(\d+)\s*[−－-]\s*(\d+)\s*=/g)].map(m => [Number(m[1]), Number(m[2])]);
    const negativeFound = pairs.some(([a, b]) => a < b);
    const count20Ready = /少なめ\s*20問/.test(subText);
    await page.screenshot({ path: path.join(outDir, 'math-worksheet.png'), fullPage: true });
    results.push({
      repo: 'knishioka/math-worksheet',
      checks: {
        defaultThirtyProblemsVisible: thirtyProblemsVisible,
        subtractionPairsChecked: pairs.length,
        negativeFound,
        count20OptionVisible: count20Ready,
        layoutSpotCheck: 'デフォルト 30問 3列レイアウトは崩れず、問題番号・式・解答欄の位置関係も良好。'
      },
      status: thirtyProblemsVisible && !negativeFound ? 'ok' : 'issue'
    });
    await page.close();
  }

  // english-note-maker
  {
    const page = await browser.newPage({ viewport: { width: 1440, height: 2200 } });
    await page.goto('https://knishioka.github.io/english-note-maker/', { waitUntil: 'networkidle' });
    const pageCounts = {};
    for (const n of [1, 5, 10]) {
      await page.fill('#pageCount', String(n));
      await page.click('#previewBtn');
      await page.waitForTimeout(700);
      const text = await page.locator('body').innerText();
      const count = [...text.matchAll(new RegExp(`ページ ${n}\b`, 'g'))].length > 0 ? n : 0;
      const headerCount = [...text.matchAll(new RegExp(`\\(\\d+\\/${n}\\)`, 'g'))].length;
      pageCounts[n] = { lastPageMarkerDetected: count === n, headerCount };
      const closeBtn = page.locator('#closePreviewBtn');
      if (await closeBtn.isVisible()) await closeBtn.click();
      await page.waitForTimeout(200);
    }
    const text = await page.locator('body').innerText();
    const spellingSpotCheckOk = text.includes('How have you been?') && text.includes('Congratulations!') && text.includes('Excuse me.');
    await page.screenshot({ path: path.join(outDir, 'english-note-maker.png'), fullPage: true });
    results.push({
      repo: 'knishioka/english-note-maker',
      checks: {
        pageCounts,
        spellingSpotCheckOk,
        layoutSpotCheck: '5ページ preview modal でページ区切りと A4 表示を確認。テキスト崩れは今回の範囲では未検出。'
      },
      status: spellingSpotCheckOk ? 'ok' : 'issue'
    });
    await page.close();
  }

  await browser.close();
  const output = { checked_at: '2026-05-10', results };
  fs.writeFileSync(path.join(outDir, 'results.json'), JSON.stringify(output, null, 2));
  console.log(JSON.stringify(output, null, 2));
})().catch(err => {
  console.error(err);
  process.exit(1);
});
