extends Node3D

# Type of ammo to use
@export
var projectile : PackedScene



# Parent Node where projectiles are put in
# Might refactor later
@export
var projectile_manager : Node



# Front of barrel wher projectiles are created at
@onready 
var muzzle := $Muzzle



@export 
var cooldown : float = 1.0



var timer : float = 0.0


# Fire projectile
func shoot():
	if(self.timer <= 0):
		var proj = projectile.instantiate();
		proj.position = muzzle.global_position;
		proj.rotation = muzzle.global_rotation;
		projectile_manager.add_child(proj);
		print("Shoot");
		self.timer = self.cooldown
	
	

func _process(delta : float):
	self.timer -= delta;
		
