//Placing Audio into a Bus
(
SynthDef("dataForABus", {
	Out.ar(
		0,
		Saw.ar(100, 0.1)
	)
}).add;
)
x = Synth("dataForABus");
x.free;

(
SynthDescLib.global.read;
SynthDescLib.global.browse;
)

//Getting Audio from a Bus
(
SynthDef("dataFromABus", {
	Out.ar(
		0,
		[
			In.ar(0, 1),
			SinOsc.ar(440, 0.2)
		]
	)
}).add;
)

y = Synth("dataFromABus");
y.free;


//Control Rate Busses
