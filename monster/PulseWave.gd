extends Node3D

@export var expand_speed : float = 200;
@export var damage : int = 1;

@onready var level = get_parent(); 

var team : Team.Enum;



func _ready():
	var player = level.get_node("Player");
	if(player):
		self.look_at(player.position);
	else:
		print("Cannot find player");



func _process(delta):
	$anchor.scale.x += delta * expand_speed
	$anchor.scale.y += delta * expand_speed
	$anchor.scale.z += delta * expand_speed



func _on_timer_timeout():
	self.queue_free()


func _on_hitbox_body_entered(target):
	target.hit(self);
