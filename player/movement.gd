extends Node3D

@onready var parent : CharacterBody3D = get_parent();
@onready var mesh = get_parent().get_node("pivot")

@export var mouse_sensitivity := 2.0
@export var speed = 100;

var _yaw_direction : float = 0.0;
var _pitch_direction : float = 0.0;



func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		self._pitch_direction = -event.relative.y; 
		self._yaw_direction = -event.relative.x;



func _physics_process(delta : float):
	var sideway = (Input.get_action_strength("move_right") - Input.get_action_strength("move_left"));
	var forward = (Input.get_action_strength("move_back") - Input.get_action_strength("move_forward"));
	var up = (Input.get_action_strength("move_up") - Input.get_action_strength("move_down"));
	var move_direction_a = parent.transform.basis.x.normalized() * sideway;
	var move_direction_b = parent.transform.basis.y.normalized() * up;
	var move_direction_c = parent.transform.basis.z.normalized() * forward;
	var move_direction = move_direction_a + move_direction_b + move_direction_c; 
	
	if move_direction != Vector3.ZERO:
		move_direction = move_direction.normalized();
		
	var roll_direction = Input.get_action_strength("roll_left") - Input.get_action_strength("roll_right");
	parent.rotate(parent.transform.basis.x.normalized(), _pitch_direction * delta);
	parent.rotate(parent.transform.basis.y.normalized(), _yaw_direction * delta);
	parent.rotate(parent.transform.basis.z.normalized(), roll_direction * 5 * delta);
	parent.velocity = move_direction * speed;
	var has_collided = parent.move_and_slide();
	
	if(has_collided):
		self._push_other_objects();
	
	self._pitch_direction = 0
	self._yaw_direction = 0
	
	
	
func _push_other_objects():
	for i in parent.get_slide_collision_count():
		var collision = parent.get_slide_collision(i)
		var collider = collision.get_collider();
		if collider is RigidBody3D:
			collider.apply_force(collision.get_normal() * -speed)	
