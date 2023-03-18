shader_type spatial;

uniform sampler2D disk_texture;

void vertex() {
	COLOR = vec4(1.0,0.3,0.0, 0.2);
}


void fragment() {
	ALBEDO = COLOR.rgb;
	ALPHA = texture(disk_texture, UV + TIME).r;
	EMISSION = COLOR.rgb;
}
