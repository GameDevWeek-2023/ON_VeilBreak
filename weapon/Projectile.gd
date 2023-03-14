extends Node3D


@export var speed : float = 1.0;
@export var lifetime : float = 5.0;

var age : float = 0.0;



func _physics_process(delta  : float):
	var direction = -get_global_transform().basis.z;
	self.translate(Vector3.FORWARD * speed * delta);
	self._manage_lifetime(delta);



# Automatic cleanup to prevent to many projectiles
func _manage_lifetime(delta : float):
	self.age += delta;
	if(age >= lifetime):
		self._destroy();



func _destroy():
	print("Projectile destroyed");
	self.queue_free();
