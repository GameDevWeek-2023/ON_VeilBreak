extends CanvasLayer

@export var player : Node;
@export var enemy : Node;



func _process(delta : float) -> void:
	self._update_bar(player, $player_health_bar);
	self._update_boost_bar(player, $player_boost_bar);
	self._update_overboost_bar(player, $player_overboost_bar);
	self._update_bar(enemy, $enemy_health_bar);



func _update_bar(entity, bar):
	if(entity && entity.has_method("get_health") && entity.has_method("get_max_health")):
		bar.min_value = 0;
		bar.value = entity.get_health();
		bar.max_value = entity.get_max_health();
		
func _update_boost_bar(entity, bar):
	if(entity && entity.has_method("get_boost") && entity.has_method("get_max_boost")):
		bar.min_value = 0;
		bar.value = entity.get_boost();
#		print(entity.get_boost());
		bar.max_value = entity.get_max_boost();
		
func _update_overboost_bar(entity, bar):
	if(entity && entity.has_method("get_overboost") && entity.has_method("get_max_overboost")):
		if(entity.get_boost() != 0):
			bar.min_value = 0;
			bar.value = entity.get_overboost();
	#		print(entity.get_boost());
			bar.max_value = entity.get_max_overboost();
