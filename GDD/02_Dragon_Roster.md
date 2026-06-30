# 02. Dragon Roster

The current prototype uses only the **Asset DML** dragon roster. Basic Dragon, Supporter Dragon, and Premium Dragon folders are not used for the dragon roster.

## Roster Rules

- 8 elements: Fire, Water, Ice, Wind, Plant, Earth, Energy, Metal.
- 40 dragons total.
- Each primary element has 5 dragons from 1 Gold to 5 Gold.
- There are no separate classes in the current build.
- Higher-cost dragons have more elements:
  - 1 Gold: 1 element.
  - 2 Gold: 2 elements.
  - 3 Gold: 2 elements.
  - 4 Gold: 3 elements.
  - 5 Gold: 3 elements.
- Shop-bought dragons use Baby assets at 1-star.
- 2-star dragons use Adult assets.
- 3-star dragons use Adult assets with a silhouette-following edge glow.
- In combat, dragons use generated attack spritesheets from `Asset DML Attack Spritesheets/` when available. The static Asset DML image remains the fallback.

## Element Effects

| Element | Current Effect |
| --- | --- |
| Fire | Attacks can apply burn damage over time. |
| Water | Attacks can fire a second shot immediately after the first shot. |
| Ice | Attacks can slow monsters. |
| Wind | Increases attack speed for all dragons. |
| Plant | Increases total damage for all dragons. |
| Earth | Attacks can knockback monsters. |
| Energy | Attacks can chain lightning to another monster in the same row. |
| Metal | Increases critical chance for all dragons. |

## Trait Tiers

| Element | 2 | 4 | 6 | 8 |
| --- | --- | --- | --- | --- |
| Fire | 20% burn chance | 35% | 55% | 75%, burn lasts 4s |
| Water | 15% second shot, 50% damage | 30%, 60% damage | 50%, 70% damage | 70%, 80% damage |
| Ice | 15% slow chance | 30% | 50% | 70%, stronger slow |
| Wind | +12% attack speed | +25% | +45% | +65% |
| Plant | +10% total damage | +25% | +45% | +70% |
| Earth | 12% knockback chance | 24% | 38% | 55% |
| Energy | 15% chain chance | 30% | 50% | 70%, 65% chain damage |
| Metal | +10% crit chance | +22% | +38% | +55% |

Trait stacks count unique dragon names currently on the board. Duplicate copies or different-star copies of the same dragon do not add extra stacks.

## Base Stats

| Cost | Damage | Attack Speed | HP | Element Count |
| ---: | ---: | ---: | ---: | ---: |
| 1 | 14 | 0.90/s | 120 | 1 |
| 2 | 20 | 0.90/s | 180 | 2 |
| 3 | 30 | 0.85/s | 260 | 2 |
| 4 | 44 | 0.80/s | 380 | 3 |
| 5 | 65 | 0.75/s | 560 | 3 |

## Star Scaling

| Star Level | Visual | Stat Scaling |
| ---: | --- | --- |
| 1 | Baby asset, bordered bronze star icon without a number | 100% HP, 100% Damage |
| 2 | Adult asset, bordered silver star icon without a number | 180% HP, 170% Damage |
| 3 | Adult asset with edge glow, bordered gold star icon without a number | 320% HP, 300% Damage |

## Fire Primary Dragons

| Cost | Dragon | Elements | Baby Asset | Adult Asset |
| ---: | --- | --- | --- | --- |
| 1 | Heavenly Dragon | Fire | `Asset DML/Fire Element/Heavenly_Dragon_Baby.png` | `Asset DML/Fire Element/Heavenly_Dragon.png` |
| 2 | Fire Dragon | Fire, Wind | `Asset DML/Fire Element/Fire_Dragon_Baby.png` | `Asset DML/Fire Element/Fire_Dragon.png` |
| 3 | Lava Dragon | Fire, Ice | `Asset DML/Fire Element/Lava_Dragon_Baby.png` | `Asset DML/Fire Element/Lava_Dragon.png` |
| 4 | Boiling Dragon | Fire, Water, Energy | `Asset DML/Fire Element/Boiling_Dragon_Baby.png` | `Asset DML/Fire Element/Boiling_Dragon.png` |
| 5 | Bludgeon Dragon | Fire, Earth, Metal | `Asset DML/Fire Element/Bludgeon_Dragon_Baby.png` | `Asset DML/Fire Element/Bludgeon_Dragon.png` |

## Water Primary Dragons

| Cost | Dragon | Elements | Baby Asset | Adult Asset |
| ---: | --- | --- | --- | --- |
| 1 | Vibrant Dragon | Water | `Asset DML/Water Element/Vibrant_Dragon_Baby.png` | `Asset DML/Water Element/Vibrant_Dragon_Adult.png` |
| 2 | Rain Dragon | Water, Ice | `Asset DML/Water Element/Rain_Dragon_Baby.png` | `Asset DML/Water Element/Rain_Dragon.png` |
| 3 | Razor Dragon | Water, Plant | `Asset DML/Water Element/Razor_Dragon_Baby.png` | `Asset DML/Water Element/Razor_Dragon.png` |
| 4 | Seahorse Dragon | Water, Ice, Plant | `Asset DML/Water Element/Seahorse_Dragon_Baby.png` | `Asset DML/Water Element/Seahorse_Dragon.png` |
| 5 | Duskwing Dragon | Water, Energy, Wind | `Asset DML/Water Element/Duskwing_Dragon_Baby.png` | `Asset DML/Water Element/Duskwing_Dragon.png` |

## Ice Primary Dragons

| Cost | Dragon | Elements | Baby Asset | Adult Asset |
| ---: | --- | --- | --- | --- |
| 1 | Flutterby Dragon | Ice | `Asset DML/Ice Element/Flutterby_Dragon_Baby.png` | `Asset DML/Ice Element/Flutterby_Dragon.png` |
| 2 | Iceberg Dragon | Ice, Plant | `Asset DML/Ice Element/Iceberg_Dragon_Baby.png` | `Asset DML/Ice Element/Iceberg_Dragon.png` |
| 3 | Ice Dragon | Ice, Water | `Asset DML/Ice Element/Ice_Dragon_Baby.png` | `Asset DML/Ice Element/Ice_Dragon.png` |
| 4 | Manta Ray Dragon | Ice, Water, Wind | `Asset DML/Ice Element/Manta_Ray_Dragon_Baby.png` | `Asset DML/Ice Element/Manta_Ray_Dragon.png` |
| 5 | Glacial Dragon | Ice, Earth, Energy | `Asset DML/Ice Element/Glacial_Dragon_Baby.png` | `Asset DML/Ice Element/Glacial_Dragon.png` |

## Wind Primary Dragons

| Cost | Dragon | Elements | Baby Asset | Adult Asset |
| ---: | --- | --- | --- | --- |
| 1 | Luck Dragon | Wind | `Asset DML/Wind Element/Luck_Dragon_Baby.png` | `Asset DML/Wind Element/Luck_Dragon.png` |
| 2 | Tundra Dragon | Wind, Ice | `Asset DML/Wind Element/Tundra_Dragon_Baby.png` | `Asset DML/Wind Element/Tundra_Dragon.png` |
| 3 | Icefeather Dragon | Wind, Ice | `Asset DML/Wind Element/Icefeather_Dragon_Baby.png` | `Asset DML/Wind Element/Icefeather_Dragon.png` |
| 4 | Porcelain Dragon | Wind, Metal, Water | `Asset DML/Wind Element/Porcelain_Dragon_Baby.png` | `Asset DML/Wind Element/Porcelain_Dragon.png` |
| 5 | Centurion Dragon | Wind, Metal, Energy | `Asset DML/Wind Element/Centurion_Dragon_Baby.png` | `Asset DML/Wind Element/Centurion_Dragon.png` |

## Earth Primary Dragons

| Cost | Dragon | Elements | Baby Asset | Adult Asset |
| ---: | --- | --- | --- | --- |
| 1 | Mud Dragon | Earth | `Asset DML/Earth Element/Mud_Dragon_Baby.png` | `Asset DML/Earth Element/Mud_Dragon.png` |
| 2 | Armadillo Dragon | Earth, Ice | `Asset DML/Earth Element/Armadillo_Dragon_Baby.png` | `Asset DML/Earth Element/Armadillo_Dragon.png` |
| 3 | Elephant Dragon | Earth, Plant | `Asset DML/Earth Element/Elephant_Dragon_Baby.png` | `Asset DML/Earth Element/Elephant_Dragon.png` |
| 4 | Sylvan Dragon | Earth, Plant, Water | `Asset DML/Earth Element/Sylvan_Dragon_Baby.png` | `Asset DML/Earth Element/Sylvan_Dragon.png` |
| 5 | Quake Dragon | Earth, Metal, Fire | `Asset DML/Earth Element/Quake_Dragon_Baby.png` | `Asset DML/Earth Element/Quake_Dragon.png` |

## Plant Primary Dragons

| Cost | Dragon | Elements | Baby Asset | Adult Asset |
| ---: | --- | --- | --- | --- |
| 1 | Melon Dragon | Plant | `Asset DML/Plant Element/Melon_Dragon_Baby.png` | `Asset DML/Plant Element/Melon_Dragon.png` |
| 2 | Sunflower Dragon | Plant, Fire | `Asset DML/Plant Element/Sunflower_Dragon_Baby.png` | `Asset DML/Plant Element/Sunflower_Dragon_Adult.png` |
| 3 | Poison Dragon | Plant, Water | `Asset DML/Plant Element/Poison_Dragon_Baby.png` | `Asset DML/Plant Element/Poison_Dragon.png` |
| 4 | Bamboo Dragon | Plant, Earth, Wind | `Asset DML/Plant Element/Bamboo_Dragon_Baby.png` | `Asset DML/Plant Element/Bamboo_Dragon.png` |
| 5 | Warden Dragon | Plant, Earth, Metal | `Asset DML/Plant Element/Warden_Dragon_Baby.png` | `Asset DML/Plant Element/Warden_Dragon.png` |

## Energy Primary Dragons

| Cost | Dragon | Elements | Baby Asset | Adult Asset |
| ---: | --- | --- | --- | --- |
| 1 | Shooting Star Dragon | Energy | `Asset DML/Energy Element/Shooting_Star_Dragon_Baby.png` | `Asset DML/Energy Element/Shooting_Star_Dragon.png` |
| 2 | Amber Dragon | Energy, Fire | `Asset DML/Energy Element/Amber_Dragon_Baby.png` | `Asset DML/Energy Element/Amber_Dragon.png` |
| 3 | Steampunk Dragon | Energy, Wind | `Asset DML/Energy Element/Steampunk_Dragon_Baby.png` | `Asset DML/Energy Element/Steampunk_Dragon.png` |
| 4 | Citrine Dragon | Energy, Fire, Metal | `Asset DML/Energy Element/Citrine_Dragon_Baby.png` | `Asset DML/Energy Element/Citrine_Dragon.png` |
| 5 | Sulfur Dragon | Energy, Fire, Earth | `Asset DML/Energy Element/Sulfur_Dragon_Baby.png` | `Asset DML/Energy Element/Sulfur_Dragon.png` |

## Metal Primary Dragons

| Cost | Dragon | Elements | Baby Asset | Adult Asset |
| ---: | --- | --- | --- | --- |
| 1 | Metal Dragon | Metal | `Asset DML/Metal Element/Metal_Dragon_Baby.png` | `Asset DML/Metal Element/Metal_Dragon.png` |
| 2 | Armored Dragon | Metal, Wind | `Asset DML/Metal Element/Armored_Dragon_Baby.png` | `Asset DML/Metal Element/Armored_Dragon.png` |
| 3 | Steel Dragon | Metal, Plant | `Asset DML/Metal Element/Steel_Dragon_Baby.png` | `Asset DML/Metal Element/Steel_Dragon.png` |
| 4 | Runestone Dragon | Metal, Earth, Energy | `Asset DML/Metal Element/Runestone_Dragon_Baby.png` | `Asset DML/Metal Element/Runestone_Dragon.png` |
| 5 | Armory Dragon | Metal, Fire, Energy | `Asset DML/Metal Element/Armory_Dragon_Baby.png` | `Asset DML/Metal Element/Armory_Dragon.png` |

## Projectile Identity

| Element | Current Projectile |
| --- | --- |
| Fire | Fireball with flame burst hit effect. |
| Water | Bubble/wave projectile; second shot proc uses wave-style projectile. |
| Ice | Ice projectile with freeze burst hit effect. |
| Wind | Wind stream/gust projectile. |
| Plant | Green leaf/poison projectile. |
| Earth | Rock projectile with stone crack hit effect and knockback. |
| Energy | Lightning projectile with snap effect and same-row chain. |
| Metal | Metal projectile with spark hit effect. |
