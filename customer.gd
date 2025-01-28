class_name Customer extends StaticBody3D

@onready var request = generate_request()
@onready var player = $"../Player"

# EVENTS

signal request_update
signal not_satisfied (cup: Cup)
signal satisfied (cup: Cup)

func _on_request_update():
	print(
		[
		"I'll have one ",
		"Can I have ",
		"One ",
		].pick_random(),
		Global.DRINKS[request]['name'],
		[
		", please.",
		"?",
		].pick_random(),
	)

func _on_not_satisfied(cup: Cup):
	if cup.volume == 0:
		print([
			"But there's nothing here..",
			"It's empty..",
			"Cup cup cup",
		].pick_random())
		return
	
	print(
		["But", "What", "Huh", "Hey"].pick_random(), ', ',
		[
		"that's not what I ordered",
		"that's not my orderer",
		"that doesn't look right",
		"what's going on",
		"excuse me",
		"there's something wrong",
		].pick_random(),
		["!", ".", "..", "...", "?", "?!"].pick_random(), ' ',
		[
		"I asked for ",
		"I wanted ",
		"I ordered ",
		"I asked you for ",
		].pick_random(),
		Global.DRINKS[request]['name'],
		["!", ".", "..", "...", "?", "?!"].pick_random(),
	)

func _on_satisfied(cup: Cup):
	cup.kill()
	print('Thanks!')
	
	print([
		'Oh and also',
		'I want more',
		'I still want coffee, hm',
	].pick_random(), '...')
	generate_request()

# HELPERS

func get_new_request() -> String:
	return Global.DRINKS.keys().pick_random()

# ACTIONS

func generate_request() -> String:
	'''Overwrites the current request with a new Drink ID'''
	request = get_new_request()
	
	request_update.emit()
	
	return request

func give(cup):
	if not cup is Cup:
		return
	
	if cup.get_similarity(request) < 80:
		not_satisfied.emit(cup)
		return
	
	satisfied.emit(cup)

# DETECTION

func _on_order_pickup_body_entered(body: Node3D):
	give(body)

func _process(delta: float):
	look_at(player.global_position)
