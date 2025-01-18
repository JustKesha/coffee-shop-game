extends CharacterBody3D

const SPEED = 175.0
const GRAVITY = 9.8

func apply_gravity(delta:float, force:float=GRAVITY):
	if is_on_floor():
		return
	
	velocity.y -= force * delta

func apply_movement(delta:float, speed:float=SPEED):
	var input_dir = Input.get_vector("left", "right", "forward", "backwards")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * speed * delta
		velocity.z = direction.z * speed * delta
	else:
		velocity.x = 0
		velocity.z = 0
	
	move_and_slide()

func _physics_process(delta:float):
	apply_movement(delta)
	apply_gravity(delta)
