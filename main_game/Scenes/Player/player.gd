extends CharacterBody3D

const SPEED : float = 5.0
const JUMP_VELOCITY : float = 4.5
const GRAVITY : float = 9.8
var grounded : bool = false


func _physics_process(delta) -> void:
	
	_handle_movement(delta)


func _handle_movement(delta) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= GRAVITY * delta

	# Handle Jump.
	if Input.is_action_just_pressed("SPACEBAR") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Add acceleration and decceleration
	var acc : float = 0.5 if is_on_floor() else 0.1
	var dec : float = 0.5 if is_on_floor() else 0.1
	
	# Handle directions.
	var input_dir = Input.get_vector("A", "D", "W", "S")
	var direction = transform.basis * Vector3(input_dir.x, 0, input_dir.y).rotated(Vector3.UP, -PI/4)
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * SPEED, acc)
		velocity.z = move_toward(velocity.z, direction.z * SPEED, acc)
	else:
		velocity.x = move_toward(velocity.x, 0, dec)
		velocity.z = move_toward(velocity.z, 0, dec)
	
	# Apply velocity.
	move_and_slide()
