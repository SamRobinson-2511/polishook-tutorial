//Carriers and modulators
(
SynthDef("fm1", {
	|bus =0, freq = 440, carPartial = 1, modPartial = 1, index = 3, mul = 0.05|
	var mod;
	var car;

	mod = SinOsc.ar(
		freq * modPartial,
		0,
		freq * index * LFNoise1.kr(5.reciprocal).abs
	);

	car = SinOsc.ar(
		(freq * carPartial) + mod,
		0,
		mul
	);

	Out.ar(
		bus,
		car
	)
}).add;
)

(
Synth("fm1", [\bus, 0, \freq, 440, \carPartial, 1, \modPartial, 2.4]);
Synth("fm1", [\bus, 1, \freq, 442, \carPartial, 1, \modPartial, 2.401]);
)

(
s.queryAllNodes;
)






