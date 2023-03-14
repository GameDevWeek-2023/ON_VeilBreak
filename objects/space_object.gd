extends RigidBody3D

@export var air_resistance : float = 0.1

func _fixed_process(delta : float):
	var drag_force := (self.linear_velocity * self.linear_velocity) * self.air_resistance;
	self.apply_force(-abs(drag_force))
	
	var drag_torque := (self.angular_velocity * self.angular_velocity) * self.air_resistance;
	self.apply_torque(-abs(drag_torque))
