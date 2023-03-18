extends Node3D



func _ready():
	self._set_scene(load("res://states/MainMenu.tscn"));



func _set_scene(scene : PackedScene):
	var child = scene.instantiate();
	child.name = "scene";
	self.add_child(child);



func _remove_scene():
	$scene.queue_free();
	self.remove_child($scene)
	


func swap_scene(scene : PackedScene):
	self._remove_scene();
	self._set_scene(scene);



func open_main_menu():
	self.swap_scene(load("res://states/MainMenu.tscn"));



func start_game():
	self.swap_scene(load("res://states/Level.tscn"));



func quit():
	get_tree().quit()
