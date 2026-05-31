@tool

extends Node3D

@onready var mirror_sprite: Sprite3D = $MirrorSprite
@onready var sub_viewport: SubViewport = $SubViewport
@onready var mirror_camera: Camera3D = $SubViewport/mirror_neck_y/mirror_neck_z/MirrorCamera
@export var resolution_width: int = 480
@export var resolution_height: int = 360
@export var width: float = 500
@export var height: float = 500
@export var Set_Up: bool = false
var on: bool = true
# Called when the node enters the scene tree for the first time.
func set_up():
	var mirror_neck_z: Node3D = $SubViewport/mirror_neck_y/mirror_neck_z
	var mirror_neck_y: Node3D = $SubViewport/mirror_neck_y
	mirror_camera.position = Vector3.ZERO
	sub_viewport.size = Vector2(resolution_width, resolution_height)
	mirror_sprite.scale = Vector3(width / resolution_width, height / resolution_height,1.0)
	mirror_camera.transform.basis = Basis.from_euler(Vector3(rotation.x, 0.0, 0.0))
	mirror_neck_y.transform.basis = Basis.from_euler(Vector3(0.0, rotation.y, 0.0))
	mirror_neck_z.transform.basis = Basis.from_euler(Vector3(0.0, 0.0, rotation.z))
	mirror_neck_y.position = position


func _ready() -> void:
	set_up()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		on = true
		if Set_Up:
			set_up()
			Set_Up = false
		
	if not on:
		mirror_sprite.hide()
		mirror_camera.current = false
	
