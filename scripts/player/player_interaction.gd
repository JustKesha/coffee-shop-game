extends RayCast3D

@onready var drag_component = $"../DragRaycast"

# HELPERS

func is_interactable(object) -> bool:
	if not object:
		return false
	
	return object is Item

func get_interaction_object():
	var object = drag_component.drag_object
	if is_interactable(object):
		return object
	
	object = get_collider()
	if is_interactable(object):
		return object
		
	return null

# DETECTION

func _unhandled_input(event: InputEvent):
	var object = get_interaction_object()
	
	if not object:
		return
	
	# NOTE Only lists Item specific interactions atm
	
	if event.is_action_pressed('use'):
		object.use()
	
	elif event.is_action_released('use'):
		object.interupt()
