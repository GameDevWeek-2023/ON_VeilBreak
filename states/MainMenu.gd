extends Node

@onready var main = get_parent(); 



func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);



func _on_start_pressed():
	main.start_game()



func _on_quit_pressed():
	main.quit()
