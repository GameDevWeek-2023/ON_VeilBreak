extends Node3D


func update_direction(direction : Vector3):
	$thruster_l.rotation = Vector3.FORWARD * direction.z
	$thruster_r.rotation = Vector3.FORWARD * direction.z
