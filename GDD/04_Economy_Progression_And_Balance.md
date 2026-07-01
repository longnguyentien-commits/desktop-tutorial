# 04. Economy, Progression And Balance

## Current Economy

Gold is the shared currency for the prototype. It is used for:

- Buying dragons.
- Rerolling shop.
- Buying Keeper XP.

Gold must use `Resource Asset/Gold_Icon.png` in UI.

## Starting Values

| Value | Current Build |
| --- | ---: |
| Starting Gold | 10 |
| Starting Keeper Level | 1 |
| Starting Board Cap | 3 |
| Dragon Egg HP | 10 |
| Bench Slots | 10 |
| Shop Slots | 5 |
| Max Keeper Level | 8 |
| Max Board Cap | 15 |
| Planning Time | 30s from wave 2 onward |

Cheat mode is currently off in the public build.

## Shop Economy

| Action | Cost |
| --- | ---: |
| Buy 1-cost dragon | 1 Gold |
| Buy 2-cost dragon | 2 Gold |
| Buy 3-cost dragon | 3 Gold |
| Buy 4-cost dragon | 4 Gold |
| Buy 5-cost dragon | 5 Gold |
| Reroll | 2 Gold |
| Lock Shop | Free |
| Buy XP | 4 Gold for 4 XP |

Additional rules:

- If the player has no Gold for a shop dragon, that shop slot is grayed out.
- If a shop slot is bought, it becomes empty.
- If all shop slots are empty, Lock Shop is disabled and grayed out.
- When a dragon reaches 3-star, that dragon is removed from future shop rolls.
- At wave clear, shop rerolls for free unless locked.

## Wave Rewards

| Wave | Reward |
| --- | ---: |
| Waves 1-19 | `8 + floor(wave x 2)` Gold, except wave 10 grants 30 Gold |
| Wave 20 | 40 Gold, then win |

Every completed wave also grants:

- +2 Keeper XP.
- Free shop reroll unless locked.

There is currently no banked-Gold interest system. The Gold HUD displays `current Gold (+wave clear reward)` so the player can see the exact payout for completing the current wave.

## Keeper Level And XP

| Keeper Level | XP To Next | Board Cap |
| ---: | ---: | ---: |
| 1 | 2 | 3 |
| 2 | 6 | 5 |
| 3 | 10 | 7 |
| 4 | 16 | 9 |
| 5 | 22 | 10 |
| 6 | 30 | 12 |
| 7 | 38 | 14 |
| 8 | MAX | 15 |

Design note:

- Wave 1 completion grants +2 XP, so the player reaches Level 2 by wave 2 and can place 5 dragons.

## Shop Odds

| Keeper Level | Cost 1 | Cost 2 | Cost 3 | Cost 4 | Cost 5 |
| ---: | ---: | ---: | ---: | ---: | ---: |
| 1 | 100% | 0% | 0% | 0% | 0% |
| 2 | 80% | 20% | 0% | 0% | 0% |
| 3 | 60% | 30% | 10% | 0% | 0% |
| 4 | 40% | 35% | 20% | 5% | 0% |
| 5 | 25% | 35% | 25% | 13% | 2% |
| 6 | 15% | 25% | 35% | 20% | 5% |
| 7 | 8% | 18% | 32% | 30% | 12% |
| 8 | 5% | 12% | 25% | 35% | 23% |

## Board Capacity

| Keeper Level | Board Cap | Formation Intent |
| ---: | ---: | --- |
| 1 | 3 | Limited opener, choose lanes carefully. |
| 2 | 5 | One dragon per lane becomes possible. |
| 3 | 7 | Early layered defense. |
| 4 | 9 | Standard mid-game formation. |
| 5 | 10 | Two dragons per lane average. |
| 6 | 12 | Late-game scaling. |
| 7 | 14 | Near full board. |
| 8 | 15 | Full board, 3 dragons per lane average. |

## Selling And Merge Value

Current design target:

| Unit State | Refund Rule |
| --- | --- |
| 1-star | 100% of unit cost |
| 2-star | `floor(cost x 3 x 0.8)` Gold |
| 3-star | `floor(cost x 9 x 0.7)` Gold |

Right-clicking a dragon displays its exact current sell value.

## Bench Recovery

- Injured dragons recover to full HP after spending one completed wave on the bench.
- The post-wave Planning row displays `Put your injured dragon on the bench to heal` when an injured board dragon exists.
- The reminder is hidden during combat, before wave 1, and when no board dragon is injured.

## Dragon Base Stats

| Cost | Damage | Attack Speed | HP | Notes |
| ---: | ---: | ---: | ---: | --- |
| 1 | 14 | 0.90/s | 120 | Weak opener, 1 element. |
| 2 | 20 | 0.90/s | 180 | Better early unit, 2 elements. |
| 3 | 30 | 0.85/s | 260 | Mid-game unit, 2 elements. |
| 4 | 44 | 0.80/s | 380 | Strong unit, 3 elements. |
| 5 | 65 | 0.75/s | 560 | Highest base stat, 3 elements. |

Star scaling:

| Star | HP | Damage |
| ---: | ---: | ---: |
| 1 | 100% | 100% |
| 2 | 180% | 170% |
| 3 | 320% | 300% |

## Element Balance

| Element | Balance Role |
| --- | --- |
| Fire | Damage over time against high HP enemies. |
| Water | Burst through second shots. |
| Ice | Lane control through slows. |
| Wind | Team attack speed, increases all on-hit value. |
| Plant | Team damage multiplier. |
| Earth | Control through knockback, not stun. |
| Energy | Same-row chain damage against clustered enemies. |
| Metal | Team critical chance. |

## Current Trait Values

| Element | 2 | 4 | 6 | 8 |
| --- | --- | --- | --- | --- |
| Fire | 20% burn | 35% burn | 55% burn | 75% burn, longer duration |
| Water | 15% second shot, 50% damage | 30%, 60% | 50%, 70% | 70%, 80% |
| Ice | 15% slow | 30% | 50% | 70%, stronger slow |
| Wind | +12% AS | +25% | +45% | +65% |
| Plant | +10% damage | +25% | +45% | +70% |
| Earth | 12% knockback | 24% | 38% | 55% |
| Energy | 15% chain | 30% | 50% | 70%, 65% chain damage |
| Metal | +10% crit | +22% | +38% | +55% |

Earth knockback distance remains tuned in combat as 32px / 48px / 64px / 80px for 2/4/6/8 stacks, but the player-facing trait text only shows the chance.

## Wave Count And Rewards

| Wave Range | Enemy Count Formula | Reward |
| --- | --- | --- |
| Wave 1 | `occupied dragon rows x 3` | 10 Gold |
| Waves 2-9 and 11-19 | `min(50, 11 + floor(wave x 2.15))` | `8 + floor(wave x 2)` Gold |
| Wave 10 | 1 Big Bad Boss | 30 Gold |
| Wave 20 | 1 Big Bad Boss | 40 Gold and win |

## Current Testing Questions

- Does Level 1 board cap of 3 feel too tight before wave 1?
- Does free +2 XP per wave make Keeper progression too fast or just right?
- Does kill/wave reward economy give enough Gold to recover after a weak wave?
- Are Water second shots and Metal crit too swingy together?
- Does Earth knockback feel visible enough without being oppressive?
- Do boss waves 10 and 20 feel fair now that bosses use one shared 5-lane hitbox and are immune to trait effects?
