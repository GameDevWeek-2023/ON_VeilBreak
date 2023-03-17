extends Node





class Idle:
	var time : float = 0;

	func _init(time : float):
		print("AI state: Idle");
		self.time = time;

	func _choose_next():
		var rng = RandomNumberGenerator.new();
		rng.randomize();
		
		var options := [
			(func(): return SpawnTurrets.new()),
			(func(): return PulseWave.new())
		];
		
		var index = rng.randi() % options.size();
		return options[index].call();
		
	func start(executor):
		pass

	func process(delta : float):
		self.time -= delta;
		if(time <= 0):
			return self._choose_next()
		else:
			return null;



class SpawnTurrets:
	func _init():
		print("AI state: SpawnTurrets");
		pass

	func start(executor):
		executor.spawn_turrets()
				
	func process(delta : float):
		return Idle.new(5.0)
		
		
		
class PulseWave:
	func _init():
		print("AI state: PulseWave");
		pass
	
	func start(executor):
		executor.pulse_wave()
	
	func process(delta : float):
		return Idle.new(5.0)




@export var turret : PackedScene;
@export var turret_count : int = 1;
@export var turret_min_distance : float = 50.0
@export var turret_max_distance : float = 100.0



@onready var parent : Node3D = self.get_parent();
@onready var state = Idle.new(5.0);
@onready var rng = RandomNumberGenerator.new();



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
		t.position = parent.position + offset;
		var level = parent.get_parent();
		level.add_child(t);


func pulse_wave():
	print("PULSE WAVE");



func _ready():
	pass



func _process(delta : float):
	var new_state = self.state.process(delta)
	if(new_state): 
		self.state = new_state; 
		self.state.start(self);
