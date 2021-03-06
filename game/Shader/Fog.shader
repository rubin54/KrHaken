shader_type canvas_item;

uniform vec3 color = vec3(0.35,0.48,0.); //rgba, make color red 
uniform int OCTAVES = 4;

float rand(vec2 coord){
	return fract(sin(dot(coord,vec2(56,78))*1000.0)*1000.0);
}

float noise(vec2 coord){
	vec2 i = floor(coord);
	vec2 f = fract(coord);
	
	float a = rand(i);
	float b = rand(i+ vec2(1.0,0.0));
	float c = rand(i+ vec2(0.0,1.0));
	float d = rand(i+ vec2(1.0,1.0));
	
	vec2 cubic = f * f * (3.0 - 2.0 * f);
	
	return mix(a,b,cubic.x) + (c-a) * cubic.y * (1.0 - cubic.x) + (d-b) * cubic.x * cubic.y;
}

float fbm(vec2 coord){   //fractal(shape),motion,
	float value = 0.1;
	float scale = 0.4;
	
	for(int i = 0;i<OCTAVES;i++){
		value += noise(coord)*scale;
		coord *= 3.0;
		scale *= 0.3;
	}
	return value;
}

void fragment(){
	vec2 coord = UV * 12.0;
	vec2 motion = vec2(fbm(coord + vec2(TIME * -1.0,TIME * 1.0)));
	float final = fbm(coord + motion);
	COLOR = vec4(color,final * 0.5);
}