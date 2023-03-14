extends RigidBody3D

@onready var parent : Node = get_parent();

func hit(projectile):
	if(parent.has_method("hit")):
		parent.hit(projectile);
