shader_type canvas_item;

uniform vec4 replace : source_color;
uniform vec4 with : source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if (COLOR == replace) {
		COLOR = with;
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
