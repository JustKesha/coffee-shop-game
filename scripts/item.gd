class_name Item extends RigidBody3D

@onready var player:Player = $"../../Player"

var is_being_used = false
var is_held = false

# EVENTS

signal used
signal interrupted

# HELPERS

func can_be_used() -> bool:
	return not is_being_used

func can_be_interrupted() -> bool:
	return is_being_used

# ACTIONS

func use():
	if not can_be_used():
		return
	
	used.emit()
	
	is_being_used = true

func interupt():
	if not can_be_interrupted():
		return
	
	interrupted.emit()
	
	is_being_used = false

func kill():
	queue_free()
