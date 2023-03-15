extends Node3D

@export var speed : float = 10;
@export var lifetime : float = 5.0;
@export var damage : int = 1.0

var team : Team.Enum;

var age : float = 0.0;


func init(team : Team.Enum):
	self.team = team;



func _ready():
	self.add_to_group("projectiles");



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
	# print("Projectile destroyed");
	self.queue_free();



func _on_body_entered(target):
	# print("Projectile: Hit");
	self._destroy();
	target.hit(self);
