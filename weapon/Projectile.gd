extends Node3D


@export var speed : float = 1.0;
@export var lifetime : float = 5.0;

var age : float = 0.0;



func _physics_process(delta  : float):
	var direction = -get_global_transform().basis.z;
	self.position += direction * speed * delta
	_manage_lifetime(delta);



# Automatic cleanup to prevent to many projectiles
func _manage_lifetime(delta : float):
	age += delta;
	if(age >= lifetime):
		print("Projectile destroyed");
		queue_free();
