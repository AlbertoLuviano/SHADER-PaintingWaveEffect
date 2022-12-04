shader_type spatial;

//Godot4 only
//If you want to use it, replace property with waveProperties[n]
//Example: sineAmplitude becomes waveProperties[0];

//uniform float[3] waveProperties;//Amplitude, Frequency, WaveSpeedDir

uniform float sineAmplitude;
uniform float sineFrequency;
uniform float sineWaveSpeedDir;
uniform vec2 centerOffset;
uniform sampler2D paintingPicture;

void fragment() {
	vec2 cPos = -1.0 + 2.0 * (UV + 0.5 - centerOffset);
	float cLength = length(cPos);
	
	vec2 newUVs = UV + (cPos/cLength) * sineAmplitude * 
		sin(sineFrequency * (cLength - (TIME * sineWaveSpeedDir)));
	
	vec2 shadow = UV + (cPos/cLength) * (sineAmplitude * 75.0) * 
		sin(sineFrequency * (cLength - (TIME * sineWaveSpeedDir)));
	
	ALBEDO = texture(paintingPicture, newUVs).rgb;
	NORMAL = vec3(shadow, NORMAL.z);
}