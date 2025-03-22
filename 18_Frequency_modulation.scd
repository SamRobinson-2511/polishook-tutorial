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

//FM synthesis and reverb
(
SynthDef("preDelay", {
	|inbus = 2|
	ReplaceOut.ar(
		4,
		DelayN.ar(In.ar(inbus, 1), 0.048, 0.048)
	)
}).add;

SynthDef("combs", {
	ReplaceOut.ar(
		6,
		Mix.arFill(7, {
			CombL.ar(In.ar(4, 1), 0.1, LFNoise1.kr(Rand(0, 0.1), 0.04, 0.05), 15)
		})
	)
}).add;

SynthDef("theMixer", {
	|gain=1|
	ReplaceOut.ar(
		0,
		Mix.ar([In.ar(2, 1), In.ar(8, 2)]) * gain
	)
}).add;
)

(
Synth("fm1", [\bus, 2, \freq, 440, \carPartial, 1, \modPartial, 1.99, \mul, 0.071]);
Synth("fm1", [\bus, 2, \freq, 442, \carPartial, 1, \modPartial, 2.401, \mul, 0.071]);
Synth.tail(s, "preDelay");
Synth.tail(s, "combs");
Synth.tail(s, "allpass");
Synth.tail(s, "theMixer", [\gain, 0.64]);
)

(
s.queryAllNodes;
)


//Components
(
SynthDef("carrier", {
	|inbus = 2, outbus=0, freq=440, carPartial=1, index=3, mul=0.2|
	var mod;
	var car;

	mod = In.ar(inbus, 1);

	Out.ar(
		outbus,
		SinOsc.ar((freq * carPartial) + mod, 0, mul);
	)
}).add;

SynthDef("modulator", {
	|outbus = 2, freq, modPartial = 1, index = 3|
	Out.ar(
		outbus,
		SinOsc.ar(freq * modPartial, 0, freq)
		*
		LFNoise1.kr(Rand(3, 6).reciprocal).abs
		*
		index
	)
}).add;
)

(
var freq = 440;
Synth.head(s, "modulator", [\outbus, 2, \freq, freq, \modPartial, 0.649, \index, 2]);
Synth.head(s, "modulator", [\outbus, 2, \freq, freq, \modPartial, 1.638, \index, 2.31]);

Synth.head(s, "modulator", [\outbus, 4, \freq, freq, \modPartial, 0.729, \index, 1.43]);
Synth.head(s, "modulator", [\outbus, 4, \freq, freq, \modPartial, 2.19, \index, 1.76]);

Synth.tail(s, "carrier", [\inbus, 2, \outbus, 0, \freq, freq, \carPartial, 1]);
Synth.tail(s, "carrier", [\inbus, 4, \outbus, 1, \freq, freq, \carPartial, 0.97]);
)

(
s.queryAllNodes;
)














