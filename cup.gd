extends Item

var VOLUME_CAP = 120

var volume = 0
var ingredients = {} # Ingredient ID to volume

# EVENTS

signal updated
signal overflow

func _on_updated() -> void:
	print(get_desc())
	
	var similarities = get_similarities()
	for drink_id in similarities:
		print(str(similarities[drink_id]) + '% ' + Global.DRINKS[drink_id]['name'])

func _on_overflow() -> void:
	print('Overflow!')
	kill()

# HELPERS

func get_difference(a:float, b:float) -> float:
	'''Returns a difference in % between the two given numbers'''
	return 100 * (abs((a - b))/((a + b)/2))

func get_similarity(drink_id) -> float:
	if not Global.DRINKS.has(drink_id):
		return -1
	
	var drink:Dictionary = Global.DRINKS[drink_id]
	var recipe:Dictionary = drink['ingredients']
	
	var similarity = 0
	
	for ingr_id in recipe:
		if not ingr_id in ingredients:
			similarity += 0
			continue
		
		var ing_percent = ingredients[ingr_id] / volume * 100
		var ing_percent_goal = recipe[ingr_id]
		
		similarity += 100 - get_difference(ing_percent, ing_percent_goal)
	
	similarity /= recipe.size()
	
	return round(similarity)

func get_similarities() -> Dictionary:
	'''Returns a dict of type Drink ID to Similarity % as float'''
	var similarities = {}
	
	for drink_id in Global.DRINKS:
		similarities[drink_id] = get_similarity(drink_id)
	
	return similarities

func get_desc() -> String:
	var out = ''
	
	for ingr_id in ingredients:
		out += ' - ' + str(ingredients[ingr_id]) + ' ml ' + ingr_id + '\n'
	
	out += '   ' + str(volume) + '/' + str(VOLUME_CAP) + '\n'
	
	return out

# ACTIONS

func add_ingredient(ingr):
	if not ingr is Ingredient:
		return
	
	if not ingr.id in ingredients:
		ingredients[ingr.id] = 0
	ingredients[ingr.id] += ingr.volume
	volume += ingr.volume
	ingr.kill()
	
	if volume > VOLUME_CAP:
		overflow.emit()
		return
	
	print('\nAdded ' + ingr.id + ', ' + str(ingr.volume) + ' ml')
	updated.emit()

# DETECTION

func _on_detector_body_entered(body: Node3D):
	add_ingredient(body)
