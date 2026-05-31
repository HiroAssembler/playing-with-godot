@tool

class_name _light_3D extends OmniLight3D

@export var energy: float = 1
@export var color_of_light: Color = Color(255.0, 255.0, 255.0, 255.0)
@export var radius: float = 6.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	light_color = color_of_light
	light_energy = energy
	omni_range = radius
	light_bake_mode = Light3D.BAKE_STATIC
	pass # Replace with function body.

func _func_godot_apply_properties(entity_properties: Dictionary) -> void:
	color_of_light = entity_properties["light color"] as Color
	energy = entity_properties["energy"] as float
	radius = entity_properties["radious"] as float
