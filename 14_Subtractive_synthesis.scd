Filter.dumpClassSubtree;

(
SynthDef("subtractive", {
	|out|
	Out.ar(
		out,
		LPF.ar(
			Pulse.ar(440, 0.5, 0.1),
			Line.kr(8000, 660, 6)
		)
	)
}).add;
)

Synth("subtractive");


//RLPF
(
SynthDef("passLowFreqs2", {
	|out|
	Out.ar(
		out,
		RLPF.ar(
			Saw.ar([220, 221]+LFNoise0.kr(1, 100, 200), 0.2),
			[LFNoise0.kr(4, 600, 2400), LFNoise0.kr(3, 600, 2400)],
			0.1
		)
	)
}).add;
)
Synth("passLowFreqs2")

//Resonz
(
SynthDef("noiseToPitch", {
	|out=0, mul=1|
	Out.ar(
		out,
		Resonz.ar(
			WhiteNoise.ar(mul),
			LFNoise0.kr(4, 110, 660),
			[0.005, 0.005]
		)
	)
}).add;
)

(
//activate left and right channels
Synth("noiseToPitch", [\out, 0, \mul, 1]);
Synth("noiseToPitch", [\out, 1, \mul, 1]);
)



















