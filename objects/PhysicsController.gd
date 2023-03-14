extends Node3D


func _ready():
	self.set_gravity(Vector3(0,0,0));



func set_gravity(force : Vector3):
	self._set(PhysicsServer3D.AREA_PARAM_GRAVITY, force.length())
	self._set(PhysicsServer3D.AREA_PARAM_GRAVITY_VECTOR, force.normalized())



func _set(param, value):
	PhysicsServer3D.area_set_param(get_world_3d().get_space(), param, value)
