# 01. Core Gameplay

## Board

- Default grid: **5 lanes x 9 columns**.
- The dragon side is on the left. Monsters attack from right to left.
- Columns 1-7: dragon placement zone. This expands the old green placement area by **2 columns to the right**.
- Columns 8-9: monster approach zone, unavailable for dragon placement.
- Each cell can contain only 1 dragon.
- A castle wall sits at the far-left end of the dragon side.
- Monsters that pass the left edge hit the castle wall and escape.
- The player has **5 HP**. Each enemy that passes the castle wall removes **1 HP**.
- The player loses when 5 enemies have passed the castle wall and HP reaches 0.

## Match Flow

- The vertical slice contains **20 waves**.
- Each wave has 2 phases:
  - **Preparation:** Buy dragons from the shop, buy XP, merge units, and place dragons on the board.
  - **Combat:** Monsters spawn according to the wave schedule, while dragons attack automatically.
- Waves 5, 10, 15, and 20 feature a mini boss or boss.

## Resources

- **Gold:** Used to buy dragons from the shop, reroll the shop, and buy XP.
- **Castle HP:** Player health, fixed at 5.
- **Bench Slot:** TFT-style reserve slots for holding unplaced dragons, default 10.
- **Keeper XP:** Progress toward the next Keeper Level.

Gold is earned primarily by killing monsters during waves.

Resource UI uses shared icons from `Resource Asset`:

| UI Value | Icon Asset |
| --- | --- |
| Gold | `Resource Asset/Gold_Icon.png` |
| Damage | `Resource Asset/Damage_Icon.png` |
| HP | `Resource Asset/Health_Icon.png` |
| Attack Speed | `Resource Asset/Attack_Speed_Icon.png` |

## Shop And Bench

- The shop behaves like Teamfight Tactics.
- The shop shows 5 random dragons.
- Each dragon has a cost from 1 Gold to 5 Gold.
- The player can buy dragons from the shop into the bench or directly onto the board if space allows.
- Reroll refreshes the 5 shop slots and costs 2 Gold.
- Lock Shop keeps the current shop for the next preparation phase.
- The bench has 10 slots.
- Selling a dragon refunds Gold based on its cost and star level.

## Keeper Level

Keeper Level controls both board cap and shop odds.

| Keeper Level | Board Cap | Cost 1 | Cost 2 | Cost 3 | Cost 4 | Cost 5 |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| 1 | 5 | 100% | 0% | 0% | 0% | 0% |
| 2 | 7 | 80% | 20% | 0% | 0% | 0% |
| 3 | 9 | 60% | 30% | 10% | 0% | 0% |
| 4 | 10 | 40% | 35% | 20% | 5% | 0% |
| 5 | 12 | 25% | 35% | 25% | 12% | 3% |
| 6 | 14 | 15% | 25% | 30% | 22% | 8% |
| 7 | 15 | 5% | 15% | 30% | 30% | 20% |

The maximum board cap is 15 dragons.

## Merge / Star Up

- 3 dragons with the same name and same star level merge into 1 higher-star dragon.
- Maximum star level: 3 stars.
- 3 copies at 1 star -> 1 copy at 2 stars.
- 3 copies at 2 stars -> 1 copy at 3 stars.
- Merge priority:
  1. Dragon currently on the board.
  2. Dragon closest to the lowest row/column position.
  3. Bench dragon if no copy is currently on the board.

## Star Stat Formula

Base dragon stats include Damage, Attack Speed, HP, and Range. Higher-cost dragons have stronger base stats before star scaling.

- 1-star: 100% stats.
- 2-star: 180% HP, 170% Damage.
- 3-star: 320% HP, 300% Damage.

| Cost | Damage | Attack Speed | HP | Stat Identity |
| ---: | ---: | ---: | ---: | --- |
| 1 | 14 | 0.90/s | 120 | Weak opener |
| 2 | 20 | 0.90/s | 180 | Better early unit |
| 3 | 30 | 0.85/s | 260 | Solid mid-game unit |
| 4 | 44 | 0.80/s | 380 | Strong carry or utility unit |
| 5 | 65 | 0.75/s | 560 | Highest base stat capstone |

Element traits modify final combat output after base cost stats and star scaling are applied.

## Combat

- Dragons prioritize the monster closest to the castle wall in their lane.
- Ranged dragons can attack within their own lane. Multi-element dragons can combine projectile visuals with trait procs.
- Monsters prefer moving straight forward.
- If a monster reaches the far-left castle wall, the player loses 1 HP and that monster disappears.
- When Castle HP reaches 0, the player loses.

## Element Synergies

Element synergies activate based on total element stacks on the board. Bench dragons do not count. Each dragon contributes 1 stack regardless of cost. Starred-up dragons still count as 1 stack unless future balance requires otherwise.

| Element | 2 stacks | 4 stacks | 6 stacks | 8 stacks |
| --- | --- | --- | --- | --- |
| Fire | 20% chance to apply burn for 1.5% monster max HP per second for 3 seconds | Burn chance increases to 35% | Burn chance increases to 55% | Burn chance increases to 75%, burn lasts 4 seconds |
| Water | 15% chance to create a Wave bonus hit for 50% damage | Wave chance increases to 30%, bonus hit deals 60% damage | Wave chance increases to 50%, bonus hit deals 70% damage | Wave chance increases to 70%, bonus hit deals 80% damage |
| Ice | 15% chance to apply 25% slow for 2 seconds | Slow chance increases to 30% | Slow chance increases to 50% | Slow chance increases to 70%, slow becomes 35% |
| Wind | +12% attack speed for all dragons | +25% attack speed for all dragons | +45% attack speed for all dragons | +65% attack speed for all dragons |
| Plant | +10% total dragon damage | +25% total dragon damage | +45% total dragon damage | +70% total dragon damage |
| Earth | 10% chance to stun for 0.5 seconds | Stun chance increases to 20% | Stun chance increases to 35% | Stun chance increases to 50%, stun lasts 0.75 seconds |
| Energy | 15% chance for attacks to chain lightning to another monster in the same row for 50% damage | Chain chance increases to 30% | Chain chance increases to 50% | Chain chance increases to 70%, chain damage becomes 65% |
| Metal | +10% critical chance for all dragons | +22% critical chance for all dragons | +38% critical chance for all dragons | +55% critical chance for all dragons |

## Projectile Styles

Projectile visuals should make element identity readable before damage numbers are needed.

| Element | Projectile Visual |
| --- | --- |
| Fire | Fireball projectile. |
| Water | Curved wave projectile; Water procs add a smaller secondary wave. |
| Ice | Ice beam projectile. |
| Wind | Wind stream projectile. |
| Plant | Leaf projectile. |
| Earth | Rock projectile. |
| Energy | Lightning bolt projectile. |
| Metal | Metal ingot projectile. |

## Input

- Click/tap a dragon in the shop to buy it.
- Drag a dragon from the shop or bench onto the grid.
- Drag a dragon on the grid to reposition it.
- Right-click/long press to sell or view tooltip details.
- Buttons: `Reroll`, `Lock`, `Buy XP`, `Start Wave`.

## Required UI

- Top bar: Wave, Castle HP, Gold, Keeper Level, XP, Board Cap.
- Board: 5 lanes, 9 columns, with the left 7 columns highlighted as the dragon placement zone.
- Castle Wall: visible at the far-left edge of the dragon side.
- Left Trait Panel: always visible on the left side of the combat UI, showing each active element as `2/4/6/8` progress.
- Shop: 5 slots with dragon name, elements, cost, star status, owned-copy count, Baby asset preview, and Gold icon for price.
- Bench: 10 reserve slots, with a warning when nearly full.
- Buy XP Button: clearly shows Gold cost and XP gained.
- Tooltip: stats with Resource Asset icons, elements, cost, star scaling, asset stage, projectile style, and trait contribution.
