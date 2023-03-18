extends CharacterBody3D

@export var team : Team.Enum = Team.Enum.NEUTRAL;

func on_death():
	get_parent().gameover();



func get_health() -> int:
	return $health.current;


func get_max_health() -> int:
	return $health.max;

func get_boost() -> float:
	return ((get_max_boost() - $Movement.boost_timer));

func get_max_boost() -> float:
	return (($Movement.boost_cd));

func get_overboost() -> float:
#	print(($Movement.overboost_timing))
	return ($Movement.overboost_timing - $Movement.overboost_time);

func get_max_overboost() -> float:
	return ($Movement.overboost_timing);
