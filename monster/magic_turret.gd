extends  "res://Shooter.gd"

@export var team : Team.Enum = Team.Enum.NEUTRAL;

@onready var player : Node3D = get_parent().get_node("Player");

func _process(delta : float):
	self.look_at(player.position);
	self._do_shoot();
	super._process(delta)
