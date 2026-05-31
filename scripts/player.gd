extends CharacterBody3D

@onready var neck: CameraController = $Neck
@onready var interface: Label = $Interface
var jump_force: Vector3 = Vector3(0.0 , 3.5, 0.0)
var want_jump: int = 0
var jump_time: int = 0
var forward_speed: float = 4.0
var side_speed: float = 3.0
var fricction: float = .7
var horizontal_speed: Vector3 = Vector3.ZERO
var max_speed: float = 15.0
var air_fricction: float = 0.94

func update_rotation(input: Vector3):
	transform.basis = Basis.from_euler(input)

func _physics_process(delta: float) -> void:
	if position.y < -70:
		position = Vector3.ZERO
		velocity = Vector3.ZERO
	
	neck.update_camera_rotation()
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	if want_jump > 0 and jump_time > 0:
		velocity += jump_force
		if not Input.is_action_pressed("jump"):
			want_jump = 0
	if is_on_floor():
		jump_time = 5
	if Input.is_action_just_pressed("jump"):
		want_jump = 5
		
	var input_vector: Vector3 = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		input_vector.z = -forward_speed
	if Input.is_action_pressed("move_backwards"):
		input_vector.z = forward_speed
	if Input.is_action_pressed("move_to_left"):
		input_vector.x = -side_speed
	if Input.is_action_pressed("move_to_right"):
		input_vector.x = side_speed
	
	#quake-like movement system
	input_vector = input_vector.normalized()
	input_vector = transform.basis * input_vector
	var current_speed: float = input_vector.dot(velocity)
	horizontal_speed = (max_speed - current_speed) * input_vector
	velocity += horizontal_speed
	if is_on_floor():
		velocity.x = velocity.x * fricction
		velocity.z = velocity.z * fricction
	else: 
		velocity.x = velocity.x * air_fricction
		velocity.z = velocity.z * air_fricction
	
	want_jump -= 1
	jump_time -= 1
	move_and_slide()
	
	interface.text = "Speed: " + str(velocity.length()) + "\n velocity components = " + str(velocity) + "\n yuri :3"

	
