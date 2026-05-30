class_name MOUSECAPTURECOMPONENT extends Node

@export var debugMouse: bool = false
@export var debugGet_Mouse: bool = false
@export_category("Mouse Capture component")
@export var current_mouse_mode: Input.MouseMode = Input.MOUSE_MODE_CAPTURED
@export var mouse_sensitivity: float = 0.005

var _mouse_input: Vector2

func _unhandled_input(event: InputEvent) -> void:
	if not event is InputEventMouseMotion:
		return
			
	if not Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		return
	
	_mouse_input.x = -event.relative.x * mouse_sensitivity
	_mouse_input.y = -event.relative.y * mouse_sensitivity
	if debugMouse:
		print(_mouse_input)

func get_mouse() -> Vector2:
	var buffer: Vector2 = _mouse_input
	_mouse_input = Vector2.ZERO
	if debugGet_Mouse:
		print("relaying" + str(_mouse_input))
	return buffer
		
func _ready() -> void:
	Input.mouse_mode = current_mouse_mode
