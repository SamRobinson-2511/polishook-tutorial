//Functions and .scope messages
s.boot;

(
{
	SinOsc.ar([440.067, 441.013], 0, 1)
	*
	SinOsc.ar([111, 109], 0, 0.2)
}.scope;
)

(
SynthDef("ringMod", {
	Out.ar(
		0,
		SinOsc.ar([440.067, 441.013], 0, 1)
		*
		SinOsc.ar([111, 109], 0, 0.2)
	)
}).add;
)
x = Synth("ringMod");
x.free;

//Multichannel Expansion

{Saw.ar([500, 933], 0.1)}.scope;
{[Saw.ar(500, 0.1), Saw.ar(933, 0.1)]}.scope;
{Saw.ar([500, 933, 2033], 0.1)}.scope;
{ Saw.ar([500, 933, 2033, 895], 0.1)}.scope;