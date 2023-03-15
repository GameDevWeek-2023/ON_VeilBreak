extends RigidBody3D

@onready var parent : Node = get_parent();
@export var team : Team.Enum = Team.Enum.NEUTRAL;

func hit(projectile):
	if(parent.has_method("hit")):
		parent.hit(projectile);
