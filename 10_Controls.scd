//Controls (usually) as arguments

(
SynthDef("withControls", {
	|freq=440, beatFreq=1, mul=0.22|
	Out.ar(
		0,
		SinOsc.ar([freq, freq+beatFreq], 0, mul)
	)
}).add;
)

z = Synth("withControls", [\freq, 440, \beatFreq, 1, \mul, 0.1]);
z.set(\freq, 700, \beatFreq, 2, \mul, 0.2);
z.free;


//Symbols and strings
Synth("withControls", [\freq, 440, \beatFreq, 0.5, \mul, 0.1])
Synth("withControls", ["freq", 440, "beatFreq", 0.75, "mul", 0.2])

//as indices
Synth("withControls", [0, 440, 1, 1, 2, 0.1]);


//To adjust a control
(
SynthDef("resetMyControls", {
	|freq=440, mul=0.22|
	Out.ar(
		0,
		SinOsc.ar([freq, freq+1], 0, mul)
	)
}).add;
)

~aSynth = Synth("resetMyControls", [\freq, 440, \mul, 0.06])
~aSynth.set(\freq, 600, \mul, 0.25)

//Environment Variables
var aSynth;
~aSynth;

(
SynthDef("controlsWithLags", {
	|freq1 = 440, freq2=443, mul=0.12|
	Out.ar(
		0,
		SinOsc.ar([freq1, freq2], 0, mul)
	)
}, [4,5]).add;
)

~aSynth = Synth("controlsWithLags", [\freq, 550, \freq2, 344, \mul, 0.1]);
~aSynth.set(\freq1, 600, \freq2, 701, \mul, 0.05);






















