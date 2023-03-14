extends Node3D

var timer : float = 0.0;
var every : float = 2.0;

@onready var weapon : Node = $Turret/Weapon;
@onready var physics := PhysicsServer3D

func _ready():
	PhysicsServer3D.area_set_param(
		get_world_3d().get_space(), 
		PhysicsServer3D.AREA_PARAM_GRAVITY,
		0
	)


func _process(delta : float):
	timer += delta;
	if(timer >= every):
		timer = 0.0;
		weapon.shoot();
