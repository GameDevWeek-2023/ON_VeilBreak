extends Node3D

@export
var projectile : PackedScene

@export
var projectile_manager : Node

@onready 
var muzzle := $Muzzle

func shoot():
	var proj = projectile.instantiate();
	proj.position = muzzle.global_position;
	proj.rotation = muzzle.global_rotation;
	projectile_manager.add_child(proj);
	print("Shoot");
	
