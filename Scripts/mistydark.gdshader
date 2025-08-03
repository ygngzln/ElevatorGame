shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	vec4 screenColor = texture(screen_texture, UV);
	
	// Vignette centered properly
	vec2 vignette_center = vec2(0.45, 0.55);
	vec2 centered_uv = (UV - vignette_center) * 2.0;
	float dist = length(centered_uv);

	float vignette_strength = 1.5;
	float vignette_radius = 0.6;

	float vignette = smoothstep(vignette_radius, vignette_radius + 0.3 * vignette_strength, dist);
	
	// Optional global darkening
	float global_darkness = 0.15;
	screenColor.rgb = mix(screenColor.rgb, vec3(0.0), global_darkness);

	// Apply vignette
	screenColor.rgb *= 1.0 - vignette * 0.8;

	COLOR = screenColor;
}
