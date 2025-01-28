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
	"ESPRESSO_MACCHIATO": {
		'name': 'Espresso Macchiato',
		'ingredients': {
			'coffee': 75,
			'milk': 25,
		}
	},
	"FLAT_WHITE": {
		'name': 'Flat White',
		'ingredients': {
			'coffee': 33.3,
			'milk': 66.6,
		}
	},
	"CAPPUCCINO": {
		'name': 'Cappuccino',
		'ingredients': {
			'coffee': 20,
			'milk': 80,
		}
	},
	"LATTE": {
		'name': 'Latte',
		'ingredients': {
			'coffee': 14.3,
			'milk': 85.3,
		}
	},
}
