extends Node3D

@onready var parent : CharacterBody3D = get_parent();
@onready var camara : SpringArm3D = parent.find_child("player_camara");
@onready var default_camara_pos = camara.spring_length;
@onready var boosted_camara_pos_length = 3;
@onready var boosted_camara_pos = default_camara_pos + boosted_camara_pos_length;

@export var mouse_sensitivity := 2.0
@export var base_speed := 50;
@export var max_speed := 3000;
@export var to_add_boost_speed := 50;

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
@export var boost_exit_timing : float = 15;
@export var boost_cd : float = 3.0;
@export var overboost_timing : float = 1.0
@export var boost_lvl_max : int = 3;

var boost_active : bool = false;
var boost_t : float = 0.0;
var boost_timer :float = 0.0;
var boost_return_timer : float = 0.0;
var target_speed : int = 0;
var overboost_time : float = 0;

var boost_lvl = 0;

func boost(delta: float) -> void:
	if (boost_timer <= 0.0):
		if (Input.is_action_pressed("boost")):
			boost_active = true;
#			drift = true
			if (boost_lvl < boost_lvl_max):
					boost_timer = boost_cd;
					target_speed = min((current_speed + to_add_boost_speed), max_speed)
					camara.interpolate(camara.spring_length, (boosted_camara_pos + boosted_camara_pos_length * boost_lvl), camara.boost_camara_curve, 0.6);
#					Input.action_release("boost");
					boost_lvl += 1;
			else:
					boost_timer = boost_cd;
					target_speed = min((current_speed), max_speed)
			
	if (boost_timer > 0.0):
		boost_t = boost_enter_curve.sample((boost_cd - boost_timer)/boost_cd);
		boost_timer -= delta;

		if (boost_timer <= 0.0):
			camara.interpolate(camara.spring_length, default_camara_pos, camara.exit_boost_camara_curve, 5);
			boost_timer = 0;
			overboost_time = overboost_timing; 
		return;
		
	elif(overboost_time > 0.0):
		overboost_time -= delta;
		if (overboost_time <= 0.0):
			overboost_time = 0;
			boost_lvl = 0;
			boost_return_timer = boost_exit_timing;
			boost_t = boost_enter_curve.sample((boost_exit_timing - boost_return_timer)/boost_exit_timing);
			boost_active = false;
#			drift = false;
		return
		
	
#	elif(boost_active > 0.0):
#		boost_t = boost_enter_curve.sample((boost_exit_timing - boost_return_timer)/boost_exit_timing);
#		target_speed = base_speed
#		print(boost_return_timer)
#		boost_return_timer -= delta;
##		print(boost_return_timer)
#		if (boost_return_timer <= 0.0):
#			boost_return_timer = 0;
#			boost_active = false;
#			boost_lvl = 0;
#		return

	
var drift = false;
		

func speed_calc(delta: float) -> void:
	boost(delta);
	if (boost_active):
		current_speed = current_speed * (1 - boost_t) +  target_speed * boost_t;
	elif(boost_return_timer > 0):
		boost_return_timer -= delta
		boost_t = boost_exit_curve.sample((boost_exit_timing - boost_return_timer)/boost_exit_timing);
		current_speed = current_speed * (1 - boost_t) +  base_speed * boost_t;
	else:
		current_speed = base_speed;
	
func toggle_drift():
		drift = !drift;
		Input.action_release("drift");
	


var last_move_direction = Vector3.ZERO;
func _physics_process(delta : float):
	var sideway = (Input.get_action_strength("move_right") - Input.get_action_strength("move_left"));
	var forward = (Input.get_action_strength("move_back") - Input.get_action_strength("move_forward"));
	var up = (Input.get_action_strength("move_up") - Input.get_action_strength("move_down"));
	if (Input.is_action_pressed("drift")):
		toggle_drift();

	
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
	
	if (move_direction != Vector3.ZERO):
		parent.velocity = move_direction * current_speed;
		last_move_direction = move_direction;
	elif(drift):
		parent.velocity = last_move_direction * current_speed;
	else:
		parent.velocity = move_direction * current_speed;
	
	_apply_gravity();	
	
	var has_collided = parent.move_and_slide();
#	print(parent.position);
	
	if(has_collided):
		self._push_other_objects();
	
	self._pitch_direction = 0
	self._yaw_direction = 0
	


func _apply_gravity():
	if(parent.level):
		for obj in parent.level.get_children():
			if(obj.has_method("get_gravity") && obj.has_method("gravity_drop_off")):
				var vec = (obj.position - parent.position);
				var dir = vec.normalized();
				var force = obj.get_gravity() * obj.gravity_drop_off(parent.position) * 100;
				parent.velocity += dir * force;
				

	
func _push_other_objects():
	for i in parent.get_slide_collision_count():
		var collision = parent.get_slide_collision(i)
		var collider = collision.get_collider();
		if collider is RigidBody3D:
			collider.apply_force(collision.get_normal() * -current_speed)	
	
