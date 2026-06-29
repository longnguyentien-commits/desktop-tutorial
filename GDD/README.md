# Dragon vs Monsters - Game Design Document

This document set tracks the current playable prototype of **Dragon vs Monsters: Hatchery Defense**, a lane-defense game inspired by Plants vs. Zombies and Teamfight Tactics.

The current build uses a 5-lane battlefield, a TFT-style shop, a 10-slot bench, Keeper XP, board-cap progression, 3-copy merging, elemental traits, kill/wave economy, and 20 waves with boss encounters on waves 10 and 20.

## Document List

- [00_Game_Overview.md](./00_Game_Overview.md): vision, fantasy, current build scope, win/lose rules.
- [01_Core_Gameplay.md](./01_Core_Gameplay.md): board rules, shop, bench, input, merge, combat, traits, UI.
- [02_Dragon_Roster.md](./02_Dragon_Roster.md): 40-dragon Asset DML roster, element effects, stats, star scaling.
- [03_Monsters_And_Waves.md](./03_Monsters_And_Waves.md): monster roster, wave pacing, boss waves, final boss.
- [04_Economy_Progression_And_Balance.md](./04_Economy_Progression_And_Balance.md): Gold, XP, shop odds, board caps, balance values.

## Working Title

**Dragon vs Monsters: Hatchery Defense**

Tagline: **Buy dragons, merge stars, and protect the tower.**

## Current Prototype Scope

- HTML5 canvas game in `Dragons vs Monsters.html`.
- 5 lanes x 9 battlefield columns.
- Left side has a tower objective and a 10-segment HP bar.
- Column 1 is reserved for the tower/breach zone; dragons are placed from column 2 onward.
- Monsters spawn from the right, move left, and damage the tower if they pass the defense line.
- Player starts with 10 HP and loses immediately at 0 HP.
- 8 dragon elements: Fire, Water, Ice, Wind, Plant, Earth, Energy, Metal.
- 40 dragons total: 8 elements x 5 costs.
- Dragons use Asset DML baby/adult sprites.
- Monsters use GIF assets from Basic Demon, Basic Monster, Basic Undead, Basic Humanoid, Toxic Sludge, Yeti, and Basic Vermin folders.
- 5-slot shop, reroll, shop lock/unlock, 10-slot bench, Buy XP, Start Wave, Speed Up / Speed 2x / Speed 3x, and Sell Dragon zone.
- Board cap scales from Keeper Level 1 to 8, ending at 15 dragons.
- 3 matching dragons merge into higher-star dragons.
- 20 waves, with Big Bad Boss encounters on waves 10 and 20.
- From wave 2 onward, players get a 30-second planning timer before the next wave auto-starts.

## Build Notes

- The game no longer uses the `Enemy Portal.mp4` asset. Portal visuals are generated in canvas; normal monsters use lane portals and boss spawns use one large portal.
- `Resource Asset/Map đấu.png` is the current battlefield background.
- `Resource Asset/Tower.webp` is the current tower/objective asset.
- `Resource Asset/Boss 1.png` and `Resource Asset/Boss 2.png` are used by the Big Bad Boss encounters on waves 10 and 20.
- `Asset DML Attack Spritesheets/` contains generated attack animations for the dragon roster.
- Tower damage feedback:
  - Below 50% HP: smoke rises from the tower/egg.
  - Below 20% HP: fire appears on the tower/egg, clipped so it stays on the asset.
- GitHub Pages target URL format:
  - `https://longnguyentien-commits.github.io/desktop-tutorial/`
