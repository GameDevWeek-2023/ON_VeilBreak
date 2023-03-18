extends CanvasLayer

@onready var main = get_parent(); 


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);



func _on_replay_pressed():
	main.start_game();



func _on_main_pressed():
	main.open_main_menu();
