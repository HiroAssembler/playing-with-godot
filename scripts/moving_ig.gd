@tool
extends AnimatableBody3D

@export var speed: float
@export var open_distance: float
# Called when the node enters the scene tree for the first time.
func _func_godot_apply_properties(entity_properties: Dictionary) -> void:
	speed = entity_properties["speed"] as float
	open_distance = entity_properties["open_distance"] as float

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		var distance: Vector3
		if distance.length_squared() < (open_distance * open_distance):
			position.y += speed
