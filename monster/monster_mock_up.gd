extends RigidBody3D

func on_death():
	get_parent().victory()
