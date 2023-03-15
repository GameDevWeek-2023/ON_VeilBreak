extends "res://Shooter.gd"

# Type of ammo to use

# Parent Node where projectiles are put in
# Might refactor later

@export var recoil_push : float = 1.0;
@export var recoil_rotate : float = 1.0;

@export var recoil_curve : Curve;

# Front of barrel wher projectiles are created at
@onready var pivot := $RecoilPivot


# Fire projectile
func shoot():
	self._do_shoot();
	
	

func _process(delta : float):
	if(self.timer > 0):
		self.timer -= delta;
	else:
		timer = 0.0;
	var t = (1.0 - self.timer) / self.cooldown
	self.pivot.position = Vector3.BACK * recoil_push * self.recoil_curve.sample(t);
	self.pivot.rotation = Vector3.RIGHT * recoil_rotate * self.recoil_curve.sample(t);
