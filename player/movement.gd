extends Node3D

@onready var parent : CharacterBody3D = get_parent();

@export var mouse_sensitivity := 2.0
@export var base_speed := 50;
@export var max_speed := 500;
@export var to_add_boost_speed := 20;

@export var movement_curve: Curve


var current_speed := base_speed;

var _yaw_direction : float = 0.0;
var _pitch_direction : float = 0.0;






func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		self._pitch_direction = -event.relative.y; 
		self._yaw_direction = -event.relative.x;
		
		
@export var boost_enter_curve: Curve
@export var boost_exit_curve: Curve
@export var boost_enter_timing : float = 2.0;
@export var boost_exit_timing : float = 1.5;
@export var boost_cd : float = 3.0;

var boost_active : bool = false;
var boost_t : float = 0.0;
var boost_timer :float = 0.0;
var boost_return_timer : float = 0.0;
var target_boost_speed : int = 0;

func boost(delta: float) -> void:
	if (boost_timer <= 0.0):
		if (Input.is_action_pressed("boost")):
			boost_active = true;
			boost_timer = boost_cd;
			boost_return_timer = boost_exit_timing;
			target_boost_speed = min((current_speed + to_add_boost_speed), max_speed)		
			
	if (boost_timer > 0.0):
		boost_t = boost_enter_curve.sample((boost_cd - boost_timer)/boost_cd);
		boost_timer -= delta;
		if (boost_timer <= 0.0):
			boost_timer = 0;
		return;
		
	elif(boost_return_timer > 0.0):
		boost_t = boost_enter_curve.sample((boost_exit_timing - boost_return_timer)/boost_exit_timing);
		boost_return_timer -= delta;
		print(boost_return_timer)
		if (boost_return_timer <= 0.0):
			boost_return_timer = 0;
			boost_active = false;
		return

		

func speed_calc(delta: float) -> void:
	boost(delta);
	if (boost_active):
		current_speed = current_speed * (1 - boost_t) +  target_boost_speed * boost_t;
	else: 
		current_speed = base_speed
	

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
		
	parent.get_node("robot").update_direction(Vector3(forward, up, sideway));
		
	var roll_direction = Input.get_action_strength("roll_left") - Input.get_action_strength("roll_right");
	parent.rotate(parent.transform.basis.x.normalized(), _pitch_direction * delta);
	parent.rotate(parent.transform.basis.y.normalized(), _yaw_direction * delta);
	parent.rotate(parent.transform.basis.z.normalized(), roll_direction * 5 * delta);
	
	speed_calc(delta);
	
	
	parent.velocity = move_direction * current_speed;
	print(current_speed)
	
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
			collider.apply_force(collision.get_normal() * -current_speed)	
	
