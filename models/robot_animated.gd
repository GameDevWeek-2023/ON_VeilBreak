extends Node3D


func update_direction(direction : Vector3):
	$body.rotation = Vector3(direction.x, 0, -direction.z) / 2.0;
	$body/hips.rotation = Vector3(direction.x, 0, -direction.z)  / 2.0;
