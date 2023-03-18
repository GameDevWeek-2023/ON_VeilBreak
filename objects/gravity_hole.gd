extends Node3D

@export var gravity_g : float = 0;
@export var teleports_to : Node3D;
@export var gravity_curve : Curve;
@export var gravity_distance : float = 100;



func get_gravity() -> float:
	return 9.81 * gravity_g;



func gravity_drop_off(other_position : Vector3) -> float:
	var r = (self.position - other_position).length(); 
#	var t = 4.0;
#	return 1 / (((r / t) + 1) ** 2);
	return gravity_curve.sample(r / gravity_distance);



func _ready():
	if($gravity_area):
		$gravity_area.gravity = self.get_gravity();




func _on_event_horizon_body_entered(body):
	print("Body fell in")
	if(self.teleports_to):
		body.position = self.teleports_to.position + Vector3(5,0,0);

