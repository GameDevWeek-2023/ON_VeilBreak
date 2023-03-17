extends Node3D

@export var team : Team.Enum = Team.Enum.ENEMY;
@export var turret : PackedScene;
@export var turret_count : int = 1;
@export var turret_min_distance : float = 50.0
@export var turret_max_distance : float = 100.0



@onready var rng = RandomNumberGenerator.new();
@onready var level = get_parent();



func _ready():
	rng.randomize();


func on_death():
	level.victory();



func get_health() -> int:
	return $health.current;



func get_max_health() -> int:
	return $health.max;



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
	print("PULSE WAVE");
