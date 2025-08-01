shader_type canvas_item;
render_mode blend_mix;

uniform sampler2D eye;
uniform vec4 color: source_color;
uniform float time: hint_range(0,1) = 0;

varying vec2 world_pos;

void vertex() {
	world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0, 1.0)).xy;
}

void fragment() {
	vec2 uv = UV;
	//bool black = FRAGCOORD.y < 100.0+zoom*640.0 || FRAGCOORD.y > 550.0-zoom*640.0;
	if(world_pos.y > 320.0){
		uv.y += time;
	}else{
		uv.y -= time;
	}
	float imageAlpha = time*2.3+0.07;
	//float imageAlpha = 1.0;
	if(false) {
		COLOR = vec4(0,0,0,imageAlpha);
	}else{
		vec4 temp = textureLod(eye, uv, 0.0);
		temp.rgb = vec3(0, 0, 0);
		if(temp.a != 0.0) {
			temp.a = imageAlpha;
		}
		COLOR = temp;
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
