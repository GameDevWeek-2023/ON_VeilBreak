@tool
extends Node2D

@export var ring_color : Color : set = _set_ring_color;
@export var back_color : Color : set = _set_back_color;
@export var start_angle  : float = 90.0 : set = _set_start_angle;
@export var end_angle : float = 0.0 : set = _set_end_angle;
@export var pointer_angle : float = 0.0  : set = _set_pointer_angle;


func _set_ring_color(color : Color):
	ring_color = color
	
	
func _set_back_color(color : Color):
	back_color = color



func _set_start_angle(value : float):
	start_angle = value;
	
	
	
func _set_end_angle(value : float):
	end_angle = value;
	
	
	
func _set_pointer_angle(value : float):
	pointer_angle = value;
	$pointer.rotation = deg_to_rad(value);
	
	
	
func _draw():
	draw_arc(Vector2(0,0), 196, deg_to_rad(0), deg_to_rad(360), 64, back_color, 64, true)
	draw_arc(Vector2(0,0), 196, deg_to_rad(self.start_angle), deg_to_rad(self.end_angle), 64, ring_color, 64, true)
	
