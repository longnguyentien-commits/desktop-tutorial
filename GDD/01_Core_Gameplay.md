# 01. Core Gameplay

## Board

- Battlefield grid: **5 lanes x 9 columns**.
- Dragons defend from left to right.
- Monsters spawn from the right and move left.
- A Dragon Egg objective sits on the far-left side and uses `Resource Asset/Tower.png`.
- The first playable column is reserved for the Dragon Egg/breach zone and cannot hold dragons.
- Dragons can be placed into empty valid board cells up to the current Keeper board cap.
- Each cell can contain only 1 dragon.
- The Dragon Egg has **10 HP**.
- Every enemy that crosses the breach line walks into the Dragon Egg, removes **1 HP**, then is removed.
- At 0 HP, the game immediately ends with **You Lost**.

## Match Flow

- The prototype contains **20 waves**.
- Wave 1 does not auto-count down. The player starts it manually after placing at least one dragon.
- From wave 2 onward, the preparation phase has a **30-second planning timer**.
- A 10-second center-screen warning appears near the end of planning time.
- The Planning HUD uses 10 progress dots per wave set. Wave 1-10 fills the first set, wave 11 resets to dot 1 for the wave 11-20 set, and dot 10 is always red to mark a boss wave.
- Boss waves display a 5-second red warning centered on the battlefield before the giant portal and boss entrance.
- The player can press **Start Wave** to begin early.
- Once a wave starts, it cannot be stopped.
- When a wave ends:
  - Player receives wave clear Gold.
  - Player receives **+2 Keeper XP**.
  - Shop rerolls for free unless it is locked.
  - Planning timer starts for the next wave.

## Resources

| Resource | Current Use |
| --- | --- |
| Gold | Buy dragons, reroll shop, buy XP. |
| Dragon Egg HP | Player life, fixed at 10 segments. |
| Bench Slots | 10 reserve slots for unplaced dragons. |
| Keeper XP | Levels up Keeper and increases board cap/shop odds. |

Resource UI uses shared icons from `Resource Asset`:

| UI Value | Icon Asset |
| --- | --- |
| Gold | `Resource Asset/Gold_Icon.png` |
| Damage | `Resource Asset/Damage_Icon.png` |
| HP | `Resource Asset/Health_Icon.png` |
| Attack Speed | `Resource Asset/Attack_Speed_Icon.png` |

## Shop

- Shop has **5 slots**.
- Each slot can contain 1 dragon.
- Shop cards are colored by tier:
  - 1 Gold: gray
  - 2 Gold: green
  - 3 Gold: blue
  - 4 Gold: purple
  - 5 Gold: yellow
- Dragon price is shown with Gold icon.
- Shop shows element icons and names vertically.
- A dragon can be bought in 2 ways:
  - Click a shop card to buy into the first available bench slot.
  - Drag from shop directly to bench or board.
- Buying a shop dragon empties that shop slot.
- If the player cannot afford a dragon, its shop slot is grayed out.
- Reroll costs **2 Gold**.
- Lock Shop is free.
- Lock Shop can only be used while at least one shop card remains. If the shop is empty, Lock is disabled/gray.
- At wave clear, the shop refreshes for free unless locked.
- Dragons that already exist as 3-star copies stop appearing in the shop.

## Bench

- Bench has **10 slots**.
- Bench dragons can be rearranged by drag/drop.
- Bench dragons can be moved onto the board if board cap and placement rules allow.
- Bench dragons show:
  - Dragon image.
  - Name label.
  - Element icons and names.
  - Tier-colored border and background matching the shop.
  - Large star icon at the upper-right.
- Dragging a bench dragon only moves the dragon image with the pointer; its nameplate, elements, and star indicator remain visible in the slot.
- An injured dragon heals to full after spending one completed wave on the bench.
- During post-wave Planning, an injured-dragon reminder appears centered in the row between the Bench label and Shop button.
- Board dragons show a tier-colored nameplate border for rarity readability.
- Right-clicking a dragon shows its current stats and **Sell for** refund value with Gold icon.
- Bench dragons can be dragged into **Sell Dragon** to sell.

## Sell Dragon

- The Sell Dragon area sits below the bench/right-side control layout.
- Dragons from the bench can be dragged into Sell Dragon.
- Before a wave starts, dragons on the board can also be moved to the bench or rearranged.
- During a wave, board dragons cannot be moved or sold.
- Selling refunds Gold based on unit cost and star level.

## Keeper Level

Keeper Level controls board cap and shop odds.

| Keeper Level | Board Cap | Cost 1 | Cost 2 | Cost 3 | Cost 4 | Cost 5 |
| ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| 1 | 3 | 100% | 0% | 0% | 0% | 0% |
| 2 | 5 | 80% | 20% | 0% | 0% | 0% |
| 3 | 7 | 60% | 30% | 10% | 0% | 0% |
| 4 | 9 | 40% | 35% | 20% | 5% | 0% |
| 5 | 10 | 25% | 35% | 25% | 13% | 2% |
| 6 | 12 | 15% | 25% | 35% | 20% | 5% |
| 7 | 14 | 8% | 18% | 32% | 30% | 12% |
| 8 | 15 | 5% | 12% | 25% | 35% | 23% |

Maximum board cap is **15 dragons**.

## Keeper XP

| Keeper Level | XP Needed To Next Level |
| ---: | ---: |
| 1 -> 2 | 2 |
| 2 -> 3 | 6 |
| 3 -> 4 | 10 |
| 4 -> 5 | 16 |
| 5 -> 6 | 22 |
| 6 -> 7 | 30 |
| 7 -> 8 | 38 |

XP rules:

- Buy XP costs **4 Gold** and grants **4 XP**.
- Clearing a wave grants **2 free XP**.
- Wave 2 is intended to reach Keeper Level 2 naturally because wave 1 grants 2 XP.

## Drag And Drop Rules

- Shop -> Bench: buy and place into selected bench slot.
- Shop -> Board: buy and place directly if the cell is valid and cap allows.
- Bench -> Board: place if cap allows.
- Bench -> Bench: swap or move.
- Board -> Board before wave: reposition or swap.
- Board -> Bench before wave: allowed.
- Board movement during wave: locked.
- During wave, the player may still add new dragons to empty board cells if board cap allows.
- During wave, the player may merge dragons, but cannot replace an occupied board dragon.
- Grid highlight only appears while dragging.

## Merge / Star Up

- 3 dragons with the same **name** and same star level merge into 1 higher-star copy.
- Maximum star level: 3.
- 3 copies at 1-star -> 1 copy at 2-star.
- 3 copies at 2-star -> 1 copy at 3-star.
- If buying or dragging a third copy completes a merge, the merge happens immediately when the target can be resolved.
- If 2 copies are on the board and the third copy is bought/dragged, both existing board copies blink; the player chooses which board position receives the upgraded dragon.
- If a player has 2 copies on bench and buys/drags the third, it merges automatically.
- Merge is allowed even when the board is already at cap, because merging reduces or preserves total unit count.
- Merge and ownership feedback:
  - Merge-ready Shop cards pulse their rectangular tier border.
  - Merge-ready Bench slots pulse their rectangular border like Shop cards.
  - Merge-ready Board dragons use a pulsing circular ring around the dragon body; Board cells do not pulse.
  - Hovering a Shop dragon gives matching Bench copies a static glowing border.
  - Hovering a Shop dragon gives matching Board copies a static circular ring.
  - Board grid squares remain reserved for drag/drop placement feedback.
- Star visuals:
  - 1-star: bronze star without a number.
  - 2-star: silver star without a number.
  - 3-star: gold star without a number.
  - Board and bench use matching bordered star visuals.
  - A 3-star dragon has a silhouette-following edge glow, not a circular aura.

## Stats

Base stats are defined by unit cost, then scaled by star level and modified by traits.

| Cost | Damage | Attack Speed | HP | Element Count |
| ---: | ---: | ---: | ---: | ---: |
| 1 | 14 | 0.90/s | 120 | 1 |
| 2 | 20 | 0.90/s | 180 | 2 |
| 3 | 30 | 0.85/s | 260 | 2 |
| 4 | 44 | 0.80/s | 380 | 3 |
| 5 | 65 | 0.75/s | 560 | 3 |

Star scaling:

| Star | HP Multiplier | Damage Multiplier |
| ---: | ---: | ---: |
| 1 | 100% | 100% |
| 2 | 180% | 170% |
| 3 | 320% | 300% |

Attack Speed means time/frequency for the next attack, not projectile travel speed.

## Combat

- Dragons face right and fire right.
- Dragons only target monsters in front of them, not behind their back.
- Dragons prioritize the nearest valid monster in their lane.
- Dragon projectiles disappear on hit.
- Projectiles that travel off-screen disappear.
- Monsters face left and move toward the Dragon Egg.
- Monsters can damage and kill dragons.
- Dead dragons are removed from the board.
- When a monster crosses the breach line, it walks into the Dragon Egg objective and Dragon Egg HP decreases by 1.
- Game stops all actions on win or loss.
- Boss waves occur on wave 10 and wave 20.
- Bosses use one large shared body/hitbox, so dragons in all 5 lanes can target and damage them.
- Bosses are immune to elemental trait effects such as burn, slow, knockback, and Energy chain splash, but still take direct projectile damage.
- Boss hit feedback uses many small randomized flashes across the boss body.

## Element Synergies

Only dragons currently on the board count for traits. Bench dragons do not count.

Important stack rule:

- Trait stacks count **unique dragon names**, not total copies.
- Two copies of the same dragon at different star levels still count as only 1 trait stack.

| Element | 2 stacks | 4 stacks | 6 stacks | 8 stacks |
| --- | --- | --- | --- | --- |
| Fire | 20% burn chance | 35% burn chance | 55% burn chance | 75% burn chance, burn lasts 4s |
| Water | 15% second shot chance, 50% damage | 30% second shot chance, 60% damage | 50% second shot chance, 70% damage | 70% second shot chance, 80% damage |
| Ice | 15% slow chance | 30% slow chance | 50% slow chance | 70% slow chance and stronger slow |
| Wind | +12% attack speed | +25% attack speed | +45% attack speed | +65% attack speed |
| Plant | +10% total damage | +25% total damage | +45% total damage | +70% total damage |
| Earth | 12% knockback chance | 24% knockback chance | 38% knockback chance | 55% knockback chance |
| Energy | 15% chain chance | 30% chain chance | 50% chain chance | 70% chain chance, 65% chain damage |
| Metal | +10% crit chance | +22% crit chance | +38% crit chance | +55% crit chance |

Earth knockback distance:

| Earth Tier | Push Distance |
| ---: | ---: |
| 2 | 32px |
| 4 | 48px |
| 6 | 64px |
| 8 | 80px |

## Projectile Styles

| Element | Projectile Visual |
| --- | --- |
| Fire | Fireball. |
| Water | Water bubble/wave; Water proc fires a second shot immediately after the first. |
| Ice | Ice beam/shard. |
| Wind | Wind stream. |
| Plant | Leaf/poison-green projectile. |
| Earth | Rock projectile. |
| Energy | Lightning bolt. |
| Metal | Metal ingot/projectile. |

Projectile travel speed is intentionally different by element. Energy is the fastest projectile type, while heavier elements such as Earth and Plant travel more slowly.

## Trait Panel And Popup

- Trait panel only displays elements with at least 1 unique on-board stack.
- If an element has 1 stack, it appears but no tier row is highlighted.
- If an element reaches 2/4/6/8, the active tier row is highlighted.
- The panel no longer shows static `2/4/6/8` text beside the title.
- Right-clicking a trait opens a popup at the cursor, centered vertically.
- Trait popup shows:
  - Element icon/name.
  - Text description and tier rows.
  - Active tier row highlight.
  - Dragons that belong to that element.
  - Dragons currently on board are bright.
  - Dragons not on board are gray.

## Tutorial And Guide Center

- Players enter an interactive tutorial scenario without using the normal match economy.
- Pressing **BATTLE** from the Main Menu/Event Lobby always starts the tutorial instead of suppressing it through a previous localStorage completion flag.
- **Skip Tutorial** closes the tutorial and starts a normal run for the current entry.
- All tutorial, action-note, completion-notice, search, and Guide Center text is in English.
- Tutorial steps cover Gold, Shop cards, buying, Bench selection, Board placement, elements/Traits, 3-copy merging, Keeper XP, level-up feedback, Drop Rates, Reroll, Lock, and Start Wave.
- The `?` button beside SFX opens the Guide Center without resetting the active match.
- Practice Tutorial opens in a separate tab so the current run remains intact.
- Dragon Forms provides searchable/filterable Baby and Adult references and can highlight owned copies on Board and Bench.

## Required UI

- Top bar: Wave, 10-dot wave-set tracker, planning timer, Dragon Egg HP, Gold, Keeper Level/XP, and Dragon Limit.
- Gold is displayed as `current Gold (+wave clear reward)`.
- Left layout: active Trait panel and Drop Rate panel.
- Pregame: loading screen, DML-style Tycoon Lobby, Events section, event panel, and Battle entry button.
- Board: 5 lanes x 9 columns, map background, Dragon Egg on the left, lane portals on normal spawns, and one large portal for boss spawns.
- Bench: 10 visible slots.
- Shop: 5 visible slots with tier colors, dragon image, elements, and Gold price.
- Right/control layout: Reroll, Lock, Start Wave, Speed Up, Buy XP, Sell Dragon.
- Buy XP uses a purple 4-cost-tier style, while Reroll keeps the yellow default button style.
- Speed Up cycles through **Speed Up -> Speed 2x -> Speed 3x -> Speed Up**.
- Game Over overlay: **You Lost** and **Play Again**.
- Win overlay: **You Won**.
