extends Node3D

@onready var parent : CharacterBody3D = get_parent();

# Called when the node enters the scene tree for the first time.
func _ready():
#	set_as_top_level(true);
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	
#func _unhandled_input(event: InputEvent) -> void:
#	if event is InputEventMouseMotion:
#		parent.look_at(parent.position, Vector3.UP);
#		rotation_degrees.x -= event.relative.y * mouse_sensitivity;
##		rotation_degrees.x = clamp(rotation_degrees.x, -90.0, 30.0);
#
#		rotation_degrees.y -= event.relative.x * mouse_sensitivity;
##		rotation_degrees.y = clamp(rotation_degrees.y, -90.0, 30.0);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
