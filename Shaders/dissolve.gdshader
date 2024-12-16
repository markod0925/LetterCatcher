shader_type canvas_item;

uniform sampler2D noise_tex;
uniform float dissolve_pct:hint_range(0.0, 1.0) = 0.0f;
uniform vec4 ask_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);

void fragment()
{
	vec4 original_color = texture(TEXTURE, UV);
	vec4 final_color = ask_color;
	final_color.a = original_color.a;
	vec4 noise = texture(noise_tex, UV);
	
	if (dissolve_pct >= noise.r)
	{
		final_color.a = 0.0;
	}
	
	COLOR = final_color;
	//COLOR.a = original_color.a;
}