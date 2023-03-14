extends Node

@export var air_resistance : float = 0.1;
@onready var parent : PhysicsBody3D = get_parent();

func _fixed_process(delta : float):
	var drag_force = (parent.linear_velocity * parent.linear_velocity) * self.air_resistance;
	parent.apply_force(-abs(drag_force))
	
	var drag_torque = (parent.angular_velocity * parent.angular_velocity) * self.air_resistance;
	parent.apply_torque(-abs(drag_torque))
