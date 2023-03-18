extends CanvasLayer

@onready var main = get_parent(); 


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
	
	

func _on_button_pressed():
	main.open_main_menu();


func _on_replay_pressed():
	main.start_game();
