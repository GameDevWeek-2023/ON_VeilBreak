extends CanvasLayer

@export var player : Node;
@export var enemy : Node;



func _process(delta : float) -> void:
	if(player && player.has_method("get_health")):
		$player_health_bar.value = player.get_health();
