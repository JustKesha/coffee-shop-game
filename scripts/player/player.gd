class_name Player extends CharacterBody3D

@onready var drag_component = $Camera/DragRaycast

func set_drag_angle(angle: Vector3 = drag_component.STABILISATION_ANGLE):
	drag_component.set_drag_angle(angle)
