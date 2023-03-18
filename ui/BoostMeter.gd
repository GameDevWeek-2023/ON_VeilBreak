extends Node2D

@export var ring_color : Color;
@export var back_color : Color;
@export var start_angle  : float = 90.0;
@export var end_angle : float = 0.0;
@export var pointer_angle : float = 0.0;



func _process(delta : float):
	$pointer.rotation = deg_to_rad(pointer_angle);



func _draw():
	draw_arc(Vector2(0,0), 196, deg_to_rad(0), deg_to_rad(360), 64, back_color, 64, true)
	draw_arc(Vector2(0,0), 196, deg_to_rad(self.start_angle), deg_to_rad(self.end_angle), 64, ring_color, 64, true)
