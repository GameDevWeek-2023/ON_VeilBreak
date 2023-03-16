extends Control

@export var min : float = 0.0;
@export var max : float = 0.0;
@export var value : float = 0.0;



func _ready():
	self._refresh_bar();#


func set_value(value : float) -> void:
	self.value = value;
	self._refresh_bar();



func set_range(min : float, max : float) -> void:
	self.min = min;
	self.max = max;
	self._refresh_bar();



func _refresh_bar():
	$front.visible = true
	$back.visible = true
	$front.size.x = self.size.x * inverse_lerp(min, max, value);
	$back.size.x = self.size.x;
