extends CharacterBody3D

#@onready var parent : CharacterBody3D = get_parent();
@onready var mesh = get_parent().get_node("pivot")

@export var mouse_sensitivity := 2.0
@export var acceleration = 5;

#@onready var camara : Node3D = get_parent().get_node("player_camara");

var target_velocity = Vector3.ZERO

var _yaw_direction : float = 0.0;
var _pitch_direction : float = 0.0;


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		self._pitch_direction = -event.relative.y; 
		self._yaw_direction = -event.relative.x;



func _physics_process(delta : float):
	
	var sideway = (Input.get_action_strength("move_right") - Input.get_action_strength("move_left"));
	var forward = (Input.get_action_strength("move_back") - Input.get_action_strength("move_forward"));
#	var move_direction = delta_x * forward + delat_y * right
	var move_direction = Vector3(sideway, 0, forward);
	
	
		
	if move_direction != Vector3.ZERO:
		move_direction = move_direction.normalized();
		
	print(move_direction)
	translate(move_direction * acceleration);
	rotate(Vector3.RIGHT, _pitch_direction * delta);
	
#	var roll_direction = Input.get_action_strength("roll_left") - Input.get_action_strength("roll_right");
#	parent.apply_torque(Vector3.RIGHT * roll_direction * 20 * delta);
#	parent.apply_torque(Vector3.FORWARD * _pitch_direction * delta);
#	parent.apply_torque(Vector3.UP * _yaw_direction   * delta);

	move_and_slide()
#
#	target_velocity.x += move_direction.x * acceleration;
#	target_velocity.z += move_direction.z * acceleration;
	
#	parent.velocity = target_velocity;

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#	camara.position = parent.position
