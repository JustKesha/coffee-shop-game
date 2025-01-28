extends Camera3D

@onready var body:CharacterBody3D = $".."
@onready var camera:Camera3D = $"."

const MOUSE_MODE = Input.MOUSE_MODE_CAPTURED

const SENSETIVITY = 0.7
const MIN_ROTATION = -75
const MAX_ROTATION = 85

const BOBBING_FREQUENCY = 4.3
const BOBBING_AMPLITUDE = 0.035

var bobbing_offset = 0.0

func _ready():
	Input.set_mouse_mode(MOUSE_MODE)

func apply_rotation(
		event:InputEventMouseMotion,
		sensetivity:float=SENSETIVITY,
		x_min:float=MIN_ROTATION,
		x_max:float=MAX_ROTATION,
		):
	body.rotate_y(-event.relative.x * sensetivity / 1000)
	rotate_x(-event.relative.y * sensetivity / 1000)
	rotation.x = clamp(
		rotation.x,
		deg_to_rad(x_min),
		deg_to_rad(x_max)
		)

func _input(event):
	if not event is InputEventMouseMotion:
		return
	
	apply_rotation(event)

func apply_head_bobbing(
		delta:float,
		offset:float,
		freq:float=BOBBING_FREQUENCY,
		ampl:float=BOBBING_AMPLITUDE,
	) -> float:
	offset += delta * body.velocity.length() * float(body.is_on_floor())
	
	var local_camera_position = Vector3(
		cos(offset * freq / 2) * ampl,
		sin(offset * freq) * ampl,
		0
	)
	
	transform.origin = local_camera_position
	
	return offset

func _process(delta):
	bobbing_offset = apply_head_bobbing(delta, bobbing_offset)
