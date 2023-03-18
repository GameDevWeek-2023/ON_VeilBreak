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
			(func(): return FollowPlayer.new()),
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

	func start(monster):
		monster.spawn_turrets()
				
	func process(delta : float):
		return Idle.new(1.0)
		
		
		
class PulseWave:
	func _init():
		print("AI state: PulseWave");
		pass
	
	func start(monster):
		monster.pulse_wave()
	
	func process(delta : float):
		return Idle.new(2.0)



class FollowPlayer:
	func _init():
		print("AI state: FollowPlayer");
		pass
	
	func start(monster):
		pass
	
	func process(delta : float):
		return LookAtPlayer.new()



class WaitThanDo:
	var time : float = 0;
	var action;

	func _init(time : float, action):
		print("AI state: WaitThanDo");
		self.time = time;
		self.action = action;

	func start(executor):
		pass

	func process(delta : float):
		self.time -= delta;
		if(time <= 0):
			return self.action.call()
		else:
			return null;


class LookAtPlayer:
	func _init():
		print("AI state: LookAtPlayer");
		pass
	
	func start(monster):
		monster.look_at_player()
	
	func process(delta : float):
		return WaitThanDo.new(1.5, func(): return MoveToPlayer.new()); 



class MoveToPlayer:
	func _init():
		print("AI state: MoveToPlayer");
		pass
	
	func start(monster):
		monster.move_to_player()
	
	func process(delta : float):
		return Idle.new(2.0)



@onready var monster : Node3D = self.get_parent();
@onready var state = WaitThanDo.new(2.0, func(): return SpawnTurrets.new());



func _ready():
	pass;



func _process(delta : float):
	var new_state = self.state.process(delta)
	if(new_state): 
		self.state = new_state; 
		self.state.start(monster);
