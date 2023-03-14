extends CharacterBody3D

@export var speed := 0;
@export var acceleration = 5;

@onready var _spring_arm: SpringArm3D = $SpringArm3D;

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	var move_direction = Vector3.ZERO;
	
#	if Input.is_action_pressed("move_right"):
#		move_direction.x += 1;
#	if Input.is_action_pressed("move_left"):
#		move_direction.x -= 1;
#	if Input.is_action_pressed("move_back"):
#		move_direction.z += 1;
#	if Input.is_action_pressed("move_forward"):
#		move_direction.z -= 1;
	
	
	move_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left");
	move_direction.z = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward");
	move_direction = move_direction.rotated(Vector3.UP, _spring_arm.rotation.y).normalized();
	if move_direction != Vector3.ZERO:
		move_direction = move_direction.normalized();
		$pivot.look_at(position + move_direction, Vector3.UP);
	
	target_velocity.x += move_direction.x * acceleration;
	target_velocity.z += move_direction.z * acceleration;
	
	velocity = target_velocity;
	move_and_slide();

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_spring_arm.position = position
