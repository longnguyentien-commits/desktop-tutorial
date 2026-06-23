# Dragon vs Monsters - Game Design Document

This document set designs a lane-based defense game inspired by Plants vs. Zombies, combined with the shop, bench, XP, and merging mechanics of Teamfight Tactics. The defending side uses 8 dragon elements: Fire, Water, Ice, Wind, Plant, Earth, Energy, and Metal. Each primary element has 5 dragons with costs from 1 Gold to 5 Gold. Dragon art uses only Asset DML for the current roster.

## Document List

- [00_Game_Overview.md](./00_Game_Overview.md): vision, fantasy, core loop, product goals.
- [01_Core_Gameplay.md](./01_Core_Gameplay.md): match rules, board, lanes, shop, bench, XP, merging, combat.
- [02_Dragon_Roster.md](./02_Dragon_Roster.md): 8-element, 40-dragon roster with costs, multi-element traits, stats, and DML assets.
- [03_Monsters_And_Waves.md](./03_Monsters_And_Waves.md): monster families, waves, bosses, and scaling.
- [04_Economy_Progression_And_Balance.md](./04_Economy_Progression_And_Balance.md): economy, shop odds, upgrades, progression, balance values.

## Working Title

**Dragon vs Monsters: Hatchery Defense**

Tagline: **Buy dragons, merge stars, and hold the castle wall.**

## Proposed Vertical Slice

- 5 lanes x 9 columns. Dragons can be placed in the left 7 columns, while monsters move from right to left.
- Castle wall on the far-left side.
- Player has 5 Castle HP; each enemy that crosses the wall removes 1 HP.
- Maximum board cap: 15 dragons, targeting 3 dragons per lane across 5 lanes.
- First playable roster: 40 dragons, with 8 elements x 5 costs.
- First monster roster: 18 enemies, including 12 normal enemies, 4 elites, and 2 bosses.
- 20 waves, with each run lasting roughly 12-18 minutes.
- TFT-style 5-slot shop, reroll, lock, 10-slot bench, Buy XP button, and a merge system where 3 copies of the same dragon combine into 1 higher-star unit.
- Gold is earned primarily by killing monsters each wave.
- Win by surviving all waves. Lose when Castle HP reaches 0.
