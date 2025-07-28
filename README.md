# Coffee Shop Game

Small simulator game I'm developing in Godot, with [barinovadn](https://github.com/barinovadn) busy on the models.<br>

> [!WARNING]
> The project is currently on pause but the work may continue in the near future.<br>
> If you're interested in contributing contact [me](../../../)!

# Gameplay

![silly screenshot](https://cdn.discordapp.com/attachments/1229518358022717594/1333840482911916126/image.png?ex=679a5b40&is=679909c0&hm=5c5391f64653848ed65aeeaf0aaf911218b243eb66cf3538d3e34eec8c8d5197&)

## 🌶️ Latest changes

* You can now pour certain ingredients like `milk` into cups.

## 🧊 Ingredients

Currently there are two ingidients in the game:
- `Milk`
- And `coffee mixture`

Some of them, like `milk` are interactable: You can start pouring it while you hold it.

You make coffee by combining named ingredients in a cup, to do so just drag & drop or slowly pour the ingredients in it.

## ☕ Coffee Math

Currently you can make a total of 5 drinks out of these two ingredients:
1. `Espresso` (100% coffee, 0% milk)
1. `Espresso Macchiato` (75/25)
1. `Flat White` (25/75)
1. `Cappuccino` (20/80)
1. `Latte` (14.3/85.3)

![silly screenshot](https://cdn.discordapp.com/attachments/1229518358022717594/1333721620296110080/image.png?ex=6799ec8d&is=67989b0d&hm=6d74d380092763f31fdf54f2363dee3cc68e5c096e577be1d171b50d733026fe&)

This customer dummy will analyse your drink, by:

1. *Calculating the average match percentage between the ingredients ratio in the recipe and the ingredients ratio in the cup.*

To make sure you get it's order right, or at least close enough!
