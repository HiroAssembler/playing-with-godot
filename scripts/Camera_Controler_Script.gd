class_name CameraController extends Node3D

@export var debug: bool = false
@export_category("Reference")
@onready var component_mouse_capture: MOUSECAPTURECOMPONENT = $"../Components"
@onready var player: CharacterBody3D = $".."
@export_category("Camera Settings")
@export_range(-90, -60) var tilt_lower_limit: int = -90
@export_range(60, 90) var tilt_upper_limit: int = 90

var _rotation: Vector3

func update_camera_rotation() -> void:
	var input = component_mouse_capture.get_mouse()
	_rotation.x += input.y
	_rotation.y += input.x
	_rotation.x = clamp(_rotation.x, deg_to_rad(tilt_lower_limit), deg_to_rad(tilt_upper_limit))
	
	#separates the pitch and yaw rotations to avoid weird problems
	var _player_rotation = Vector3(0.0, _rotation.y, 0.0)
	var _camera_rotation = Vector3(_rotation.x, 0.0, 0.0)
	
	transform.basis = Basis.from_euler(_camera_rotation)
	player.update_rotation(_player_rotation)
	
	rotation.z = 0.0
