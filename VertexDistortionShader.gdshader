shader_type spatial;
render_mode diffuse_toon;

// Godot4 only
//If you want to use it, replace property with waveProperties[n]
//Example: sineAmplitude becomes waveProperties[0];

//uniform float[5] waveProperties;//Amplitude, Frequency, PhaseShift, VerticalShift, WaveSpeedDir

uniform float sineAmplitude;
uniform float sineFrequency;
uniform float sineManualPhaseShift;
uniform float sineManualVerticalShift;
uniform float sineWaveSpeedDir;
uniform vec2 centerOffset;
uniform sampler2D paintingPicture;

void vertex(){
	float vOffset = sqrt(pow(VERTEX.x + centerOffset.x, 2.0)
		+ pow(VERTEX.y + centerOffset.y, 2.0));
	float vWave = (sineAmplitude * //Amplitude
		sin((sineFrequency) * //Frequency
		((vOffset - sineManualPhaseShift + (TIME * sineWaveSpeedDir)) ))) //PhaseShift & WaveDirSpeed
		+ sineManualVerticalShift; //VerticalShift
	VERTEX.z = vWave;
}

void fragment() {
	ALBEDO = texture(paintingPicture, UV).rgb;
}