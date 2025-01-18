extends RayCast3D

var DRAG_SPEED = 5.0
var ZOOM_SPEED = 0.25
var ZOOM_MIN = 0.5
var ZOOM_MAX = 2.0

var drag_object: RigidBody3D
var drag_distance: float

func get_collision_distance() -> float:
	if not is_colliding():
		return -1
	
	return global_transform.origin.distance_to(get_collision_point())

func start_dragging(new_drag_object: RigidBody3D):
	if drag_object:
		stop_dragging()
	
	new_drag_object.freeze = true
	
	drag_object = new_drag_object
	drag_distance = get_collision_distance()

func stop_dragging():
	if not drag_object:
		return
	
	drag_object.freeze = false
	
	drag_object = null

func set_drag_distance(new_value: float):
	if not drag_object:
		return
	
	drag_distance = clamp(new_value, ZOOM_MIN, ZOOM_MAX)

func _input(event):
	if event.is_action_pressed('interact'):
		var aimed_object = get_collider()
		
		if aimed_object is RigidBody3D:
			start_dragging(aimed_object)
	
	elif event.is_action_released('interact'):
		stop_dragging()
	
	if event.is_action_pressed('zoom_in'):
		set_drag_distance(drag_distance - ZOOM_SPEED)
	elif event.is_action_pressed('zoom_out'):
		set_drag_distance(drag_distance + ZOOM_SPEED)

func drag(
	delta: float,
	drag_object: RigidBody3D = drag_object,
	speed: float = DRAG_SPEED ):
	if not drag_object:
		return
	
	var forward = -get_global_transform().basis.z
	var drag_position = global_position + forward * drag_distance
	var new_object_position = drag_object.global_position.lerp(drag_position, speed * delta)
	
	drag_object.global_position = new_object_position

func _process(delta: float) -> void:
	drag(delta)
