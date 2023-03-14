extends Node3D

@onready var weapon : Node = $Turret/Weapon;
@onready var physics := PhysicsServer3D

func _ready():
	PhysicsServer3D.area_set_param(
		get_world_3d().get_space(), 
		PhysicsServer3D.AREA_PARAM_GRAVITY,
		0
	)
	pass


func _process(delta : float):
	weapon.shoot();
