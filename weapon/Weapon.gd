extends Node3D

# Type of ammo to use
@export var projectile : PackedScene;

# Parent Node where projectiles are put in
# Might refactor later
@export var projectile_manager : Node;

@export var cooldown : float = 1.0;

@export var recoil_push : float = 1.0;
@export var recoil_rotate : float = 1.0;

@export var recoil_curve : Curve;

# Front of barrel wher projectiles are created at
@onready var muzzle := $RecoilPivot/Muzzle
@onready var pivot := $RecoilPivot

var timer : float = 0.0


# Fire projectile
func shoot():
	if(self.timer <= 0):
		var proj = projectile.instantiate();
		proj.position = muzzle.global_position;
		proj.rotation = muzzle.global_rotation;
		projectile_manager.add_child(proj);
		print("Shoot");
		self.timer = self.cooldown;
	
	

func _process(delta : float):
	if(self.timer > 0):
		self.timer -= delta;
	else:
		timer = 0.0;
	var t = (1.0 - self.timer) / self.cooldown
	self.pivot.position = Vector3.BACK * recoil_push * self.recoil_curve.sample(t);
	self.pivot.rotation = Vector3.RIGHT * recoil_rotate * self.recoil_curve.sample(t);
