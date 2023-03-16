extends CanvasLayer

@export var player : Node;
@export var enemy : Node;



func _process(delta : float) -> void:
	self._update_bar(player, $player_health_bar);
	self._update_bar(enemy, $enemy_health_bar);



func _update_bar(entity, bar):
	if(entity && entity.has_method("get_health") && entity.has_method("get_max_health")):
		bar.min_value = 0;
		bar.value = entity.get_health();
		bar.max_value = entity.get_max_health();
