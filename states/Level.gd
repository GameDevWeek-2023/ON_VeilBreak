extends Node3D

@onready var main : Node = get_parent();




func _process(delta):
#	self.gameover()
	pass



func gameover():
	main.swap_scene(load("res://states/GameOver.tscn"))
