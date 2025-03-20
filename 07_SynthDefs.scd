(
SynthDef("aSynthDef", { //name
	|freq| //uGenGraphFunction
	Out.ar(
		0,
		SinOsc.ar(freq, 0, 0.1)
	)
}
).load(s);
)

//SynthDef browser
(
SynthDescLib.global.read;
SynthDescLib.global.browse;
)

