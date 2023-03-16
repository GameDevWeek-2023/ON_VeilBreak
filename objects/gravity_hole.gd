extends Node3D

@export var gravity_g : float = 0;

func _ready():
	$Area3D.gravity = 9.81 * gravity_g;
