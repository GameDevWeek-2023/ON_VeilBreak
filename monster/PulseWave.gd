extends Node3D

@export var expand_speed : float = 100;
@export var damage : int = 1;

var team : Team.Enum;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$anchor.scale.x += delta * expand_speed
	$anchor.scale.y += delta * expand_speed
	$anchor.scale.z += delta * expand_speed


func _on_timer_timeout():
	self.queue_free()


func _on_hitbox_body_entered(target):
	target.hit(self);
