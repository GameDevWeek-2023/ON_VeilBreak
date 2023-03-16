extends Node3D

@export var gravity_g : float = 0;
@export var teleports_to : Node3D;

func _ready():
	$gravity_area.gravity = 9.81 * gravity_g;




func _on_event_horizon_body_entered(body):
	print("Body fell in")
	if(self.teleports_to):
		body.position = self.teleports_to.position

