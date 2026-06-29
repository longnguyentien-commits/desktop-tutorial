const path = require("node:path");
const { pathToFileURL } = require("node:url");
const { test, expect } = require("@playwright/test");

const gameUrl = pathToFileURL(path.resolve(__dirname, "..", "Dragons vs Monsters.html")).href;

test("game loads, buys a dragon, and keeps the board stable", async ({ page }) => {
  const pageErrors = [];
  page.on("pageerror", error => pageErrors.push(error.message));

  await page.goto(gameUrl);
  await expect(page.locator("#game")).toBeVisible();
  await expect(page.locator("[data-shop]")).toHaveCount(5);
  await page.waitForFunction(() => canDrawImage(img(icon.battleMap)) && canDrawImage(img(icon.tower)));

  const before = await page.locator("#game").boundingBox();
  expect(before).not.toBeNull();

  await page.locator("[data-shop]").first().click();
  await expect(page.locator("[data-bench].filled")).toHaveCount(1);

  const after = await page.locator("#game").boundingBox();
  expect(after).not.toBeNull();
  expect(after.width).toBeCloseTo(before.width, 1);
  expect(after.height).toBeCloseTo(before.height, 1);
  expect(after.x).toBeCloseTo(before.x, 1);
  expect(after.y).toBeCloseTo(before.y, 1);
  expect(pageErrors).toEqual([]);

  const canvasImage = await page.locator("#game").screenshot();
  expect(canvasImage.byteLength).toBeGreaterThan(10000);
});
