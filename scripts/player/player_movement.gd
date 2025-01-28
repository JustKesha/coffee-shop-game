extends Node3D

const SPEED = 175.0
const GRAVITY = 9.8

@onready var rigidbody = $".."

func apply_gravity(delta:float, force:float=GRAVITY):
	if rigidbody.is_on_floor():
		return
	
	rigidbody.velocity.y -= force * delta

func apply_movement(delta:float, speed:float=SPEED):
	var input_dir = Input.get_vector("left", "right", "forward", "backwards")
	var direction = (rigidbody.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		rigidbody.velocity.x = direction.x * speed * delta
		rigidbody.velocity.z = direction.z * speed * delta
	else:
		rigidbody.velocity.x = 0
		rigidbody.velocity.z = 0
	
	rigidbody.move_and_slide()

func _physics_process(delta:float):
	apply_movement(delta)
	apply_gravity(delta)
