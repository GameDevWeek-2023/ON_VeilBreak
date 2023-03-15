extends Node3D

@export var projectile : PackedScene;
@export var user : Node;
@export var cooldown : float = 1.0;

# Front of barrel wher projectiles are created at
@export var muzzle : Node;

var timer : float = 0.0


# Fire projectile
func _do_shoot():
	if(self.timer <= 0):
		var proj = projectile.instantiate();
		proj.position = muzzle.global_position;
		proj.rotation = muzzle.global_rotation;
		proj.init(user.team);
		user.get_parent().add_child(proj);
		# print("Shoot");
		self.timer = self.cooldown;
	
func _process(delta : float):
	self.timer -= delta;
