extends Node

@export var max : int = 1;

@onready var current = max;

@onready var parent : Node = get_parent();



func on_shot(projectile : Node):
	self.current -= projectile.damage;
	if(self.current <= 0):
		self._die()



func _die():
	self._delegate_to_parent()
	self._delegate_to_siblings()
	parent.queue_free();
	


func _delegate_to_parent():
	if(parent.has_method("on_death")):
		parent.on_death();



func _delegate_to_siblings():
	for sibling in parent.get_children():
		if(sibling.has_method("on_death")):
			sibling.on_death()
