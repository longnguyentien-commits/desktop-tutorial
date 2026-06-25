# 03. Monsters And Waves

The attacking side uses animated monster assets from multiple folders. The current prototype favors GIF enemies for visible movement.

## Current Enemy Asset Sources

| Source Folder | Current Use |
| --- | --- |
| Basic Demon Animations | Crimson Imp, Floating Eye, Pit Balor/final boss. |
| Basic Monster Animations | Red Cap, Ocular Watcher, Bloodshot Eye, Crushing Cyclops. |
| Basic Undead Animations | Decrepit Bones, Bound Cadaver. |
| Basic Humanoid Animations | Goblin Fighter, Lizardfolk Spearman. |
| Toxic Sludge Animations | Toxic Sludge, Volatile Sludge. |
| Yeti Animations | Yeti. |
| Basic Vermin Animations | Tunnel Mole, Swooping Bat, Famished Tick. |

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

## Final Boss

| Boss | Asset | Base HP | Speed | Notes |
| --- | --- | ---: | ---: | --- |
| Ancient Siege Boss | `Basic Demon Animations/pit balor/PitBalor.gif` | 3200 | 8 | Wave 20 boss encounter. Current start text says five bosses attack every lane. |

Wave 20 currently spawns one boss entry per lane. The visual goal remains a giant final boss that feels large enough to threaten all 5 lanes.

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
| Waves 2-19 | `min(50, 11 + floor(wave x 2.15))` |
| Wave 20 | 5 boss spawns |

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

## Mini Boss Waves

The design target is mini boss pressure on waves **5, 10, and 15**.

Current implementation:

- The enemy pool unlocks stronger/special enemies over time.
- Heavy units such as Yeti, Pit Balor, and Crushing Cyclops enter later waves.
- Wave 5 difficulty has been reduced compared to earlier tests so it is less punishing.

Next implementation pass should explicitly inject 5 mini bosses across 5 lanes on waves 5/10/15 while preserving normal wave enemies.

## 20-Wave Arc

| Wave | Current Intent |
| ---: | --- |
| 1 | Tutorial wave. Spawns only in lanes with dragons. |
| 2 | More lanes and enough XP to reach Keeper Level 2. |
| 3 | Basic mixed pressure. |
| 4 | Toxic Sludge unlocks. |
| 5 | Special enemies begin. Mini boss pressure target. |
| 6 | Bound Cadaver unlocks. |
| 7 | Ocular Watcher unlocks. |
| 8 | Lizardfolk Spearman unlocks. |
| 9 | Heavier mixed wave. |
| 10 | Yeti unlocks. Mini boss pressure target. |
| 11 | Larger mixed wave. |
| 12 | Pit Balor unlocks. |
| 13 | More special cadence pressure. |
| 14 | Crushing Cyclops unlocks. |
| 15 | Mini boss pressure target. |
| 16 | High-density mixed wave. |
| 17 | Late-game durability check. |
| 18 | Final preparation pressure. |
| 19 | Final rush before boss. |
| 20 | Final boss encounter. |

## Wave Rewards

| Wave | Clear Reward |
| --- | ---: |
| 1-19 | `5 + floor(wave x 1.5)` Gold |
| 20 | 40 Gold, then win |

Wave clear also grants **+2 XP** and a free shop reroll if the shop is not locked.

## Castle/Tower Damage

- Player starts with 5 Tower HP.
- Every escaped enemy removes 1 HP.
- Escaped enemies disappear.
- Damage numbers appear near the tower.
- Below 50% HP, smoke rises from the tower.
- Below 20% HP, fire appears on the tower but is clipped to the asset area.
- At 0 HP, the game stops and displays **You Lost**.

## Portal Behavior

- The old `Enemy Portal.mp4` asset is not used.
- Portal visuals are generated in canvas.
- Portal is lane-specific.
- A portal appears only in the lane where an enemy has just spawned.
- Portal fades out after the spawn.
