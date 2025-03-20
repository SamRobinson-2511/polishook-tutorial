//Audio Rate
//default = 44.1k samples/second

(
SynthDef("anExample", {
	Out.ar(
		0,
		Pulse.ar(
			[220, 221.5] + SinOsc.kr([7, 8], 0, 7),
			0.35,
			0.02
		)
	)
}).add;
)

Synth("anExample");