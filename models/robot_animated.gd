extends Node3D

@export var animation_blend_speed = 10.0

var _current_point : Vector2 = Vector2.ZERO;
var _target_point : Vector2 = Vector2.ZERO;



func _ready():
	$AnimationTree.active = true


func update_direction(direction : Vector3):
	self._target_point = Vector2(direction.z, -direction.x);



func _process(delta : float):
	var delta_direction = (self._target_point - self._current_point);
	self._current_point += delta_direction * delta * animation_blend_speed;
	$AnimationTree.set("parameters/Fly/blend_position", self._current_point);



