extends Node3D

@export var team : Team.Enum = Team.Enum.NEUTRAL;

func on_death():
	get_parent().gameover();



func get_health() -> int:
	return $health.current;



func get_max_health() -> int:
	return $health.max;
