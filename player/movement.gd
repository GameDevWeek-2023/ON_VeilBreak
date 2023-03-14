extends Node3D

@onready var parent = get_parent();
@onready var mesh = get_parent().get_node("pivot")

@export var acceleration = 5;

@onready var camara: SpringArm3D = get_parent().get_node("player_camara");

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	var move_direction = Vector3.ZERO;
	
	move_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left");
	move_direction.z = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward");
	move_direction = move_direction.rotated(Vector3.UP, camara.rotation.y).normalized();
	if move_direction != Vector3.ZERO:
		move_direction = move_direction.normalized();
		
	
	
	
	target_velocity.x += move_direction.x * acceleration;
	target_velocity.z += move_direction.z * acceleration;
	
	parent.velocity = target_velocity;
	parent.move_and_slide();

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camara.position = parent.position
