extends StaticBody3D

@export var team : Team.Enum = Team.Enum.NEUTRAL;
@onready var parent : Node = get_parent();



func hit(projectile):
	if(projectile.team != self.team):
		self._delegate_to_parent(projectile)
		self._delegate_to_siblings(projectile)


func _delegate_to_parent(projectile):
	if(parent.has_method("on_shot")):
		parent.on_shot(projectile);
	else:
		print_debug("Parent has not hit(projectile)")



func _delegate_to_siblings(projectile):
	for sibling in parent.get_children():
		if(sibling.has_method("on_shot")):
			sibling.on_shot(projectile)
