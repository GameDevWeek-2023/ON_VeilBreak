extends RigidBody3D

@export var team : Team.Enum = Team.Enum.NEUTRAL;

func on_death():
	get_parent().victory()
