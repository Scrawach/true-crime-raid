shader_type spatial;
render_mode unshaded;
stencil_mode read, write, compare_not_equal, 1;

uniform vec4 color: source_color;

void vertex() {
	
}

void fragment() {
	ALPHA = color.a;
	ALBEDO = vec3(color.r, color.g, color.b);
}