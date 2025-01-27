extends Node

var DRINKS = {
	# Drink ID
	"ESPRESSO": {
		'name': 'Espresso',
		# Ingredient ID to volume %
		'ingredients': {
			'coffee': 100,
		}
	},
	"LATTE": {
		'name': 'Latte',
		'ingredients': {
			'coffee': 33.3,
			'milk': 66.6,
		}
	},
	"CAPPUCCINO": {
		'name': 'Cappuccino',
		'ingredients': {
			'coffee': 50,
			'milk': 50,
		}
	},
	"FLAT_WHITE": {
		'name': 'Flat White',
		'ingredients': {
			'coffee': 25,
			'milk': 75,
		}
	},
}
