extends Node3D



enum FadeState {
	IN, OUT, NONE
}

var fade_state = FadeState.NONE;


var alpha = 1.0


func _ready():
	for c in self.get_children():
		for i in range(0, c.mesh.get_surface_count()):
			c.mesh.surface_get_material(i).transparency = BaseMaterial3D.Transparency.TRANSPARENCY_ALPHA_DEPTH_PRE_PASS;


func _process(delta):
	if(fade_state == FadeState.IN):
		alpha = clamp(alpha + delta, 0, 1);
	if(fade_state == FadeState.OUT):
		alpha = clamp(alpha - delta, 0, 1);
	if(fade_state != FadeState.NONE):
		for c in self.get_children():
			for i in range(0, c.mesh.get_surface_count()):
				c.mesh.surface_get_material(i).albedo_color.a = alpha;



func fade_out():
	self.fade_state = FadeState.OUT;	


func fade_in():
	self.fade_state = FadeState.IN;	
