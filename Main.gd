extends Node3D



func _ready():
	self._set_scene(load("res://states/Test.tscn"));



func _set_scene(scene : PackedScene):
	var child = scene.instantiate();
	child.name = "scene";
	self.add_child(child);



func _remove_scene():
	$scene.queue_free();
	


func swap_scene(scene : PackedScene):
	self._remove_scene();
	self._set_scene(scene);
