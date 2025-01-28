extends RayCast3D

var DRAG_FORCE = 350.0
var DRAG_RELATIVE_POSITION = Vector3.UP * .1

var ZOOM_SPEED = 0.15
var ZOOM_MIN = 0.5
var ZOOM_MAX = 1.65

var STABILISATION_SPEED = 3.5
var STABILISATION_ANGLE = Vector3(.2, 1, 0)

var drag_object: RigidBody3D
var drag_distance: float

# HELPERS

func get_collision_distance() -> float:
	if not is_colliding():
		return -1
	
	return global_transform.origin.distance_to(get_collision_point())

func is_object_draggable(object) -> bool:
	if object is RigidBody3D:
		return true
	
	return false

func get_draggable_aimed() -> RigidBody3D:
	var object_aimed = get_collider()
	
	if is_object_draggable(object_aimed):
		return object_aimed
	
	return null

func get_drag_position() -> Vector3:
	var forward = -get_global_transform().basis.z
	
	return global_position + forward * drag_distance + DRAG_RELATIVE_POSITION

func get_drag_velocity(
	delta: float,
	force: float = DRAG_FORCE,
	object: RigidBody3D = drag_object,
	) -> Vector3:
	if not object:
		return Vector3.ZERO
	
	return (get_drag_position() - object.global_position) * delta * force

# SETTERS

func set_drag_distance(value: float):
	drag_distance = clamp(value, ZOOM_MIN, ZOOM_MAX)

func set_drag_object(object: RigidBody3D):
	if drag_object:
		stop_dragging()
	
	drag_object = object

# ACTIONS

func start_dragging(
	object: RigidBody3D = get_draggable_aimed(),
	distance: float = get_collision_distance(),
	):
	if not object:
		return
	
	if drag_object:
		stop_dragging()
	
	set_drag_object(object)
	set_drag_distance(distance)

func stop_dragging():
	if not drag_object:
		return
	
	drag_object.sleeping = false
	drag_object = null

func apply_drag(
	delta: float,
	force: float = DRAG_FORCE,
	object: RigidBody3D = drag_object,
	):
	if not object:
		return
	
	object.linear_velocity = get_drag_velocity(delta, force, object)
	object.angular_velocity = Vector3.ZERO
	
	object.rotation = object.rotation.lerp(
		STABILISATION_ANGLE, delta * STABILISATION_SPEED)

# CONTROLS

func _input(event):
	if event.is_action_pressed('interact'):
		start_dragging()
	
	elif event.is_action_released('interact'):
		stop_dragging()
	
	if event.is_action_pressed('zoom_in'):
		set_drag_distance(drag_distance - ZOOM_SPEED)
	
	elif event.is_action_pressed('zoom_out'):
		set_drag_distance(drag_distance + ZOOM_SPEED)

func _physics_process(delta: float) -> void:
	apply_drag(delta)
