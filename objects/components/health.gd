extends Node

@export var max : int = 1;

@onready var current = max;

@onready var parent : Node = get_parent();

func on_shot(amount : int):
	self.current -= amount;
	if(self.current <= 0):
		parent.queue_free();
