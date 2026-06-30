# 03. Monsters And Waves

The attacking side uses animated monster assets from multiple folders. The current prototype favors GIF enemies for visible movement.

## Current Enemy Asset Sources

| Source Folder | Current Use |
| --- | --- |
| Basic Demon Animations | Crimson Imp, Floating Eye, Pit Balor. |
| Basic Monster Animations | Red Cap, Ocular Watcher, Bloodshot Eye, Crushing Cyclops. |
| Basic Undead Animations | Decrepit Bones, Bound Cadaver. |
| Basic Humanoid Animations | Goblin Fighter, Lizardfolk Spearman. |
| Toxic Sludge Animations | Toxic Sludge, Volatile Sludge. |
| Yeti Animations | Yeti. |
| Basic Vermin Animations | Tunnel Mole, Swooping Bat, Famished Tick. |
| Resource Asset | Big Bad Boss wave 10 and wave 20 boss sprites. |

## Current Enemy Roster

| Enemy | Asset | Base HP | Speed | Unlock Wave | Notes |
| --- | --- | ---: | ---: | ---: | --- |
| Crimson Imp | `Basic Demon Animations/crimson imp/CrimsonImp.gif` | 80 | 34 | 1 | Fast early demon. |
| Red Cap | `Basic Monster Animations/Red Cap/RedCap.gif` | 110 | 24 | 1 | Basic monster. |
| Decrepit Bones | `Basic Undead Animations/Decrepit Bones/DecrepitBones.gif` | 140 | 19 | 2 | Slow undead. |
| Goblin Fighter | `Basic Humanoid Animations/goblin fighter/GoblinFighter.gif` | 125 | 26 | 3 | Basic humanoid. |
| Toxic Sludge | `Toxic Sludge Animations/3/3 Animation.gif` | 170 | 18 | 4 | Toxic bruiser. |
| Floating Eye | `Basic Demon Animations/floating eye/FloatingEye.gif` | 120 | 31 | 5 | Flying special enemy. |
| Tunnel Mole | `Basic Vermin Animations/Tunneling Mole/TunnelingMole.gif` | 155 | 24 | 5 | Burrow special enemy. |
| Bound Cadaver | `Basic Undead Animations/Bound Cadaver/BoundCadaver.gif` | 220 | 15 | 6 | Durable undead. |
| Ocular Watcher | `Basic Monster Animations/Ocular Watcher/OcularWatcher.gif` | 210 | 17 | 7 | Durable monster. |
| Hex Eye | `Basic Monster Animations/Bloodshot Eye/BloodshotEye.gif` | 190 | 14 | 5 | Ranged debuff special. |
| Lizardfolk Spearman | `Basic Humanoid Animations/lizardfolk spearman/LizardfolkSpearman.gif` | 210 | 23 | 8 | Durable humanoid. |
| Volatile Sludge | `Toxic Sludge Animations/6/6 Animation.gif` | 260 | 16 | 5 | Splitter special. |
| Swooping Bat | `Basic Vermin Animations/Swooping Bat/SwoopingBat.gif` | 96 | 39 | 5 | Flying special. |
| Famished Tick | `Basic Vermin Animations/Famished Tick/FamishedTick.gif` | 78 | 55 | 5 | Very fast special. |
| Yeti | `Yeti Animations/1/1.gif` | 380 | 13 | 10 | Heavy enemy. |
| Pit Balor | `Basic Demon Animations/pit balor/PitBalor.gif` | 430 | 12 | 12 | Heavy demon. |
| Crushing Cyclops | `Basic Monster Animations/Crushing Cyclops/CrushingCyclops.gif` | 500 | 11 | 14 | Heavy late-game monster. |

## Boss Waves

| Boss | Asset | Base HP | Speed | Notes |
| --- | --- | ---: | ---: | --- |
| Big Bad Boss | `Resource Asset/Boss 1.png` | 20800 | 7.5 | Wave 10 boss. Appears after the wave 10 normal monster group is cleared. |
| Big Bad Boss | `Resource Asset/Boss 2.png` | 41600 | 6.5 | Wave 20 final boss. Appears after the wave 20 normal monster group is cleared. |

Bosses use one shared large body and hitbox instead of five separate lane bodies. Dragons from all 5 lanes can target and damage the boss. Bosses face left, spawn from one giant portal, and are immune to elemental trait effects such as burn, slow, knockback, and chain splash. They still receive direct projectile damage.

## Enemy Scaling

- Normal enemies use `hpScale = 1 + wave * 0.16`.
- Boss enemies do not use normal wave HP scaling.
- Enemy spawn interval during waves:
  - `max(0.26, 0.78 - wave * 0.018)` seconds.
- Monsters face left.
- Monsters can attack dragons.
- Some monsters fire enemy projectiles or apply range debuffs.
- Flying enemies bob visually and show a shadow.
- Burrowing enemies squash underground temporarily.

## Wave Enemy Count

| Wave Rule | Enemy Count |
| --- | ---: |
| Wave 1 | `occupied dragon rows x 3` |
| Waves 2-9 and 11-19 | `min(50, 11 + floor(wave x 2.15))` |
| Wave 10 | 14 normal monsters, then 1 Big Bad Boss |
| Wave 20 | 22 normal monsters, then 1 Big Bad Boss |

Boss wave rule:

- Normal monsters spawn first.
- The boss does not appear until all normal monsters in that boss wave are cleared.
- The boss counts as the final spawn of that wave.

Wave 1 special rule:

- The player must place at least one dragon before starting wave 1.
- Wave 1 only spawns monsters in rows that currently contain dragons.
- If the player places dragons in fewer than 5 rows, unused rows do not spawn wave 1 enemies.

## Special Enemy Cadence

From wave 5 onward, special enemies can appear if unlocked.

Special cadence:

- `max(3, 6 - floor((wave - 5) / 2))`
- This means special enemies appear more often as waves progress.

Special enemies include:

- Tunnel Mole
- Hex Eye
- Volatile Sludge
- Swooping Bat
- Famished Tick
- Floating Eye

## Heavy Pressure Waves

Current implementation:

- The enemy pool unlocks stronger/special enemies over time.
- Heavy units such as Yeti, Pit Balor, and Crushing Cyclops enter later waves.
- Wave 5 difficulty has been reduced compared to earlier tests so it is less punishing.
- Wave 10 is now the first dedicated boss wave.
- Wave 20 is the final boss wave.

## 20-Wave Arc

| Wave | Current Intent |
| ---: | --- |
| 1 | Tutorial wave. Spawns only in lanes with dragons. |
| 2 | More lanes and enough XP to reach Keeper Level 2. |
| 3 | Basic mixed pressure. |
| 4 | Toxic Sludge unlocks. |
| 5 | Special enemies begin. |
| 6 | Bound Cadaver unlocks. |
| 7 | Ocular Watcher unlocks. |
| 8 | Lizardfolk Spearman unlocks. |
| 9 | Heavier mixed wave. |
| 10 | Yeti unlocks. First Big Bad Boss wave. |
| 11 | Larger mixed wave. |
| 12 | Pit Balor unlocks. |
| 13 | More special cadence pressure. |
| 14 | Crushing Cyclops unlocks. |
| 15 | Heavy mixed pressure. |
| 16 | High-density mixed wave. |
| 17 | Late-game durability check. |
| 18 | Final preparation pressure. |
| 19 | Final rush before boss. |
| 20 | Final Big Bad Boss encounter. |

## Wave Rewards

| Wave | Clear Reward |
| --- | ---: |
| 1-19 | `8 + floor(wave x 2)` Gold, except wave 10 grants 30 Gold |
| 20 | 40 Gold, then win |

Wave clear also grants **+2 XP** and a free shop reroll if the shop is not locked.

## Dragon Egg Damage

- Player starts with 10 Dragon Egg HP.
- Every escaped enemy walks into the Dragon Egg objective and removes 1 HP.
- Enemies are removed after entering the Dragon Egg.
- Damage numbers appear near the Dragon Egg.
- Below 50% HP, smoke rises from the Dragon Egg.
- Below 20% HP, fire appears on the Dragon Egg but is clipped to the asset area.
- At 0 HP, the game stops and displays **You Lost**.

## Portal Behavior

- The old `Enemy Portal.mp4` asset is not used.
- Portal visuals are generated in canvas.
- Portal is lane-specific.
- A portal appears only in the lane where an enemy has just spawned.
- Boss spawns use one giant portal centered vertically on the right side instead of five lane portals.
- Portal fades out after the spawn.
