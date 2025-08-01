shader_type canvas_item;
render_mode blend_mix;

uniform sampler2D rect;
uniform sampler2D dissolveTexture;
uniform vec4 color: source_color;
uniform float time: hint_range(0,1) = 0;
uniform bool direction = false;

varying vec2 world_pos;

void vertex() {
	world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0, 1.0)).xy;
}

float rand(vec2 co){
  return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void fragment() {
	vec2 uv = UV;
	float random = rand(uv);
	float cutoff = random * 1000.0 + 700.0;
	float xVal = world_pos.x;
	if(direction == false) xVal = 1200.0-xVal;
	if(xVal < time*cutoff) {
		COLOR = vec4(0, 0, 0, 0);
	}else{
		vec4 main = texture(rect, UV);
		vec4 noise = texture(dissolveTexture, UV);
		float val = 0.15*cos(6.28*(time+0.2))+0.7;
		val = 0.9-time;
		main.a = floor((val) + min(1, noise.x));
		main.a -= time*0.8;
		COLOR = vec4(color.rgb, main.a);
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
