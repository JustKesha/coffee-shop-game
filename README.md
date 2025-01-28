# Coffee Shop Game
This is a small first-person 3D game I'm developing in Godot 4.3, with [barinovadn](https://github.com/barinovadn) busy on the models part. Very soon it is to become a complete coffee making simulator. But as of now you can read on the current state of the project below!

1. [About](#coffee-shop-game)
1. [Gameplay](#gameplay)
    - [Ingidients combining](#ingidients-combining)
    - [Drink type calculation](#drink-type-calculation)

# Gameplay

![silly screenshot](https://cdn.discordapp.com/attachments/1229518358022717594/1333653703013568592/image.png?ex=6799ad4c&is=67985bcc&hm=b39ff40af7b5ab97ff417dc5ead551227bb00fb747cf0892ed7a37a041402f90&)

## 🧊 Ingidients combining

Currently there have been two ingidients added to the game:
- `Milk`
- And `coffee mixture`

You make coffee by combining the right proportions of those two in a cup, to do so you can simply drag and drop the ingredients in it.

## ☕ Drink type calculation

Currently you can make a total of 5 drinks out of these two ingredients:
1. `Espresso` (100% coffee, 0% milk)
1. `Espresso Macchiato` (75/25)
1. `Flat White` (25/75)
1. `Cappuccino` (20/80)
1. `Latte` (14.3/85.3)

![silly screenshot](https://cdn.discordapp.com/attachments/1229518358022717594/1333721620296110080/image.png?ex=6799ec8d&is=67989b0d&hm=6d74d380092763f31fdf54f2363dee3cc68e5c096e577be1d171b50d733026fe&)<br>
This customer dummy will analyse your drink, using complex wizardry, to make sure you get the ratio of ingredients on it's order is right, or at least close enough.

[Code in game](./scripts/cup.gd)

```
1 coffee, 2 milk

80% Flat White
66% Cappuccino
48% Latte
```

*Here is a python code snippet that represents this logic.*

```python
# Ingredient -> volume
ingredients = {'coffee': 29.9, 'milk': 120.1}
drink_volume = sum(ingredients.values())

# Ingredient -> perfect percentage ratio
recipe = {'coffee': 20, 'milk': 80}

accuracy = 0

for ingr in recipe:
    if not ingr in ingredients:
        continue
    
    percent = ingredients[ingr]/drink_volume*100
    goal = recipe[ingr]

    accuracy += 100-(abs(percent-goal)/((percent+goal)/2))*100

accuracy = accuracy/len(recipe.keys())
```
```
99.79140577903337
```


The project is pretty fresh so that's about it on the interesting part for now.

![silly screenshot](https://cdn.discordapp.com/attachments/1229518358022717594/1333720322045771797/image.png?ex=6799eb58&is=679899d8&hm=afddb7c6278dce2524846ae2cb98cb70e31766a603b96acd738067d082583c88&)