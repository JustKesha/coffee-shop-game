extends Ingredient

var POUR_ANGLE = Vector3(.95, 1.9, 2.1)

# NOTE Should be added to all inherited scenes
@onready var pour_raycast_start:Node3D = $PourRaycastStart
@onready var pour_raycast = $PourRaycast
@onready var pour_delay_timer = $PourDelay
@onready var pour_tick_timer = $PourTick

var is_pouring = false

# EVENTS

signal emptied
signal spilled (how_much: float)

func _on_emptied():
	kill()

func _on_spilled(how_much: float):
	pass
	
func _on_used():
	player.set_drag_angle(POUR_ANGLE)
	start_pouring_delay()

func _on_interrupted():
	player.set_drag_angle()
	stop_pouring()

# HELPER OVERWRITES

func can_be_used() -> bool:
	return is_held and not is_being_used

func safe_look_at(node: Node3D, target: Vector3):
	var origin: Vector3 = node.global_transform.origin
	var v_z = (origin - target).normalized()

	if origin == target:
		return

	var up = Vector3.ZERO
	for entry in [Vector3.UP, Vector3.RIGHT, Vector3.BACK]:
		var v_x: Vector3 = entry.cross(v_z).normalized()
		if v_x.length() != 0:
			up = entry
			break

	if up != Vector3.ZERO:
		node.look_at(target, up)

# ACTIONS

func start_pouring_delay():
	pour_delay_timer.start(0)

func start_pouring():
	is_pouring = true
	pour_tick_timer.start(0)
	update_pour_raycast_position()
	update_pour_raycast_angle()

func stop_pouring():
	is_pouring = false
	pour_tick_timer.stop()

func pour_into(object, how_much: float = -1):
	if how_much < 0:
		how_much = get_meta("pour_per_tick")
	
	how_much = clamp(how_much, 0, get_meta("volume"))
	
	# Atm can only pour into cups
	if( object
		and object is Cup ):
		object.add_ingredient_data(get_meta("id"), how_much)
	else:
		spilled.emit(how_much)
	
	var new_volume = get_meta("volume") - how_much
	
	set_meta("volume", new_volume)
	
	if new_volume <= 0:
		emptied.emit()

func pour():
	if not is_pouring:
		return
		
	update_pour_raycast_position()
	update_pour_raycast_angle()
	
	pour_into(pour_raycast.get_collider())

# SETTERS

func update_pour_raycast_position():
	pour_raycast.position = pour_raycast_start.position

func update_pour_raycast_angle():
	var pos = pour_raycast_start.global_position + Vector3.DOWN
	safe_look_at(pour_raycast, pos)

# DETECTION

func _on_pour_delay_timeout():
	start_pouring()

func _on_pour_tick_timeout():
	pour()
