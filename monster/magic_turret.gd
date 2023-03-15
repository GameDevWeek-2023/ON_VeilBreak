extends  "res://Shooter.gd"

@export var team : Team.Enum = Team.Enum.NEUTRAL;

func _process(delta : float):
	self._do_shoot();
	super._process(delta)
