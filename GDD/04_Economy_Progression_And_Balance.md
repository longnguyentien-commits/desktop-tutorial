# 04. Economy, Progression And Balance

## In-Match Economy

Gold is earned primarily by killing monsters during each wave. There is no automatic large income at the start of a round in the first balance pass. This makes combat performance directly feed the player's shop power.

Gold is the shared currency for the whole game and must use `Resource Asset/Gold_Icon.png` in the top bar, shop prices, reroll cost, Buy XP cost, rewards, and tooltips.

| Gold Source | Proposed Value |
| --- | ---: |
| Small monster kill | +1 Gold |
| Normal monster kill | +1 Gold |
| Bruiser/Fast monster kill | +2 Gold |
| Elite kill | +4 Gold |
| Boss kill | +8 Gold or artifact choice |
| Perfect wave bonus, no Castle HP lost | +2 Gold |
| Interest per 10 held Gold | +1 Gold, max +3 |
| Selling a dragon | Refund based on cost and star level |

## Shop Economy

- Shop has 5 slots.
- Reroll costs 2 Gold.
- Lock Shop is free.
- Dragons cost 1-5 Gold based on their unit cost.
- The shop pool contains 40 dragons: 8 elements x 5 costs.
- Higher Keeper Level unlocks better odds for higher-cost dragons.

## Keeper Level And XP

| Next Keeper Level | XP Required | Gold Cost If Bought Directly |
| ---: | ---: | ---: |
| 2 | 2 | 4 |
| 3 | 6 | 8 |
| 4 | 10 | 12 |
| 5 | 18 | 20 |
| 6 | 28 | 32 |
| 7 | 42 | 48 |

Each wave can grant a small amount of XP if needed, but the primary progression lever is the **Buy XP** button.

## Board Capacity By Keeper Level

| Keeper Level | Board Cap | Shop Identity |
| ---: | ---: | --- |
| 1 | 5 | Cheap openers only |
| 2 | 7 | First stable formation |
| 3 | 9 | Start seeing 3-cost dragons |
| 4 | 10 | Mid-game board |
| 5 | 12 | 4-cost dragons appear |
| 6 | 14 | Late-game transition |
| 7 | 15 | Full board, 5-cost dragons are realistic |

## Shop Odds

| Keeper Level | Cost 1 | Cost 2 | Cost 3 | Cost 4 | Cost 5 |
| --- | ---: | ---: | ---: | ---: | ---: |
| 1 | 100% | 0% | 0% | 0% | 0% |
| 2 | 80% | 20% | 0% | 0% | 0% |
| 3 | 60% | 30% | 10% | 0% | 0% |
| 4 | 40% | 35% | 20% | 5% | 0% |
| 5 | 25% | 35% | 25% | 12% | 3% |
| 6 | 15% | 25% | 30% | 22% | 8% |
| 7 | 5% | 15% | 30% | 30% | 20% |

## Selling And Merge Value

| Unit State | Refund Rule |
| --- | --- |
| 1-star | 100% of unit cost |
| 2-star | 80% of total combined cost |
| 3-star | 70% of total combined cost |

Merge cost is based on copies:

- 3 matching 1-star dragons -> 1 matching 2-star dragon.
- 3 matching 2-star dragons -> 1 matching 3-star dragon.

## Castle HP And Failure Pressure

- Player starts with 5 Castle HP.
- Each enemy that crosses the far-left castle wall removes 1 HP.
- When 5 total enemies have crossed, Castle HP reaches 0 and the player loses.
- No enemy should deal more than 1 Castle HP damage in the first prototype. This keeps the fail state readable.

## Proposed Artifacts

Artifacts drop from bosses/elites or appear in post-wave reward choices, then can be equipped onto dragons.

| Artifact | Effect | Best Fit |
| --- | --- | --- |
| Ember Core | Burn chance +8% | Fire |
| Tide Pearl | Wave chance +8% | Water |
| Ice Scale | Slow chance +8% | Ice |
| Gale Feather | Attack speed bonus +8% | Wind |
| Wildroot Charm | Total damage bonus +8% | Plant |
| Quake Core | Stun chance +6% | Earth |
| Storm Lens | Chain lightning chance +8% | Energy |
| Iron Fang | Critical chance +8% | Metal |

## Sample Compositions

### Fire Burn

- Core: Fire units across multiple costs.
- Playstyle: use frequent hits and burn chance to kill high-HP monsters over time.
- Weakness: enemies that rush through before burn has time to tick.

### Water Wave

- Core: Water units plus high-damage multi-element dragons.
- Playstyle: Wave bonus hits multiply strong base attacks.
- Weakness: lower value if base attack damage is too low.

### Ice Control

- Core: Ice units plus damage backline.
- Playstyle: slow monsters so the castle wall is protected.
- Weakness: control-resistant bosses.

### Wind Tempo

- Core: Wind units plus on-hit elements.
- Playstyle: attack faster to trigger more element effects.
- Weakness: needs enough damage scaling to avoid long fights.

### Plant Damage

- Core: Plant units plus any carry element.
- Playstyle: increase total team damage.
- Weakness: does not directly protect Castle HP.

### Earth Stun

- Core: Earth units in lanes with dangerous single targets or fast enemies.
- Playstyle: stun monsters to interrupt movement and buy time for backline damage.
- Weakness: stun chance can feel inconsistent without enough Earth stacks or attack speed.

### Energy Row Clear

- Core: Energy units in lanes with dense monster traffic.
- Playstyle: same-row chain damage against clustered waves.
- Weakness: weaker against isolated targets.

### Metal Crit

- Core: Metal units plus Wind or Water.
- Playstyle: increase critical chance and multiply many hits.
- Weakness: inconsistent if critical chance is too low.

## Starting Prototype Stats

Dragon base stat displays use:

- Damage: `Resource Asset/Damage_Icon.png`
- HP: `Resource Asset/Health_Icon.png`
- Attack Speed: `Resource Asset/Attack_Speed_Icon.png`

| Cost | Damage | AS | HP | Range | Notes |
| ---: | ---: | ---: | ---: | ---: | --- |
| 1 | 14 | 0.9/s | 120 | 4 cells | Weak opener, 1 element |
| 2 | 20 | 0.9/s | 180 | 4 cells | Better early unit, 2 elements |
| 3 | 30 | 0.85/s | 260 | 4 cells | Solid mid-game unit, 2 elements |
| 4 | 44 | 0.8/s | 380 | 5 cells | Strong carry or utility, 3 elements |
| 5 | 65 | 0.75/s | 560 | 5 cells | Highest base stat capstone, 3 elements |

Element traits apply after base cost stats and star multipliers. For example, Plant increases final damage, Wind increases final attack speed, Metal increases critical chance, and Earth adds stun chance instead of HP.

| Monster Type | HP | Damage | Speed | Gold On Kill |
| --- | ---: | ---: | ---: | ---: |
| Swarm | 45 | 1 | 1.4 | 1 |
| Normal | 100 | 1 | 1.0 | 1 |
| Bruiser | 250 | 1 | 0.7 | 2 |
| Ranged | 120 | 1 | 0.8 | 1 |
| Fast | 75 | 1 | 1.8 | 2 |
| Elite | 700 | 1 | 0.6 | 4 |
| Boss | 3000 | 1 | 0.45 | 8 |

## Early Balance Questions To Test

- Does kill-based Gold create a comeback problem if the player is already behind?
- Are shop odds generous enough to find pairs and 2-star units?
- Is 5 Castle HP too punishing for new players?
- Are 7 placement columns too much defensive space for 20 waves?
- Does earning Gold during combat make the shop phase feel rewarding enough?
