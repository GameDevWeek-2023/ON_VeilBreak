extends Node3D

@export var team : Team.Enum = Team.Enum.ENEMY;
@export var turret : PackedScene;
@export var turret_count : int = 1;
@export var turret_min_distance : float = 50.0
@export var turret_max_distance : float = 100.0

@export var wave : PackedScene;

@export var move_speed : float = 10.0
@export var move_margin : float = 100.0

@onready var rng = RandomNumberGenerator.new();
@onready var level = get_parent();
@onready var dest_position := self.position;

@onready var player : Node = level.get_node("Player")



func gravity_drop_off(other_position : Vector3) -> float:
	var free_zone_inner = 250;
	var free_zone_outer = 500;
	var gravity_strength_inner = 0.1;
	var gravity_strength_outer = 0.001;
	var r = (self.position - other_position).length(); 
	if(r <= free_zone_inner):
		return -gravity_strength_inner / (r / free_zone_inner);
	if(r >= free_zone_outer):
		return gravity_strength_outer * (r - free_zone_outer);
	return 0
	

func get_gravity() -> float:
	return 9.81;



func _ready():
	rng.randomize();



func on_death():
	level.victory();



func _physics_process(delta : float):
	var distance = self.dest_position - self.position;
	
	if(distance.length() <= self.move_margin):
		self.dest_position = self.position
	else:
		var direction = distance.normalized();
		self.position = self.position.move_toward(self.dest_position, delta * self.move_speed)



func get_health() -> int:
	return $health.current;



func get_max_health() -> int:
	return $health.max;
	
	
	
func move_to_player():
	if(player):
		self.dest_position = player.position;



func look_at_player():
	if(player):
		$model.fade_out();
		$fade_timer.start();



func spawn_turrets():
	for x in range(0, self.turret_count):
		var distance_x = rng.randf_range(self.turret_min_distance, self.turret_max_distance);
		var distance_y = rng.randf_range(self.turret_min_distance, self.turret_max_distance);
		var distance_z = rng.randf_range(self.turret_min_distance, self.turret_max_distance);
		var offset = Vector3(
			distance_x * (1.0 if (rng.randi() % 2 == 0) else -1.0),
			distance_y * (1.0 if (rng.randi() % 2 == 0) else -1.0),
			distance_z * (1.0 if (rng.randi() % 2 == 0) else -1.0),
		) 
		var t : Node = turret.instantiate();
		t.position = position + offset;
		level.add_child(t);



func pulse_wave():
	var w : Node = wave.instantiate();
	w.position = position;
	w.team = self.team;
	level.add_child(w);



func _on_fade_timer_timeout():
	self.look_at(player.position);
	$model.fade_in();
