//RECEIVER - OPERATOR - OPERAND
s.boot;
//Mixing = addition
//mix two sawtooth waves
(
{
	Saw.ar(500, 0.05)
	+
	Saw.ar(600, 0.06)
}.scope;
)

//mix three unit generators

(
{
	Saw.ar(500, 0.05)
	+
	Saw.ar(600, 0.06)
	+
	Saw.ar(700, 0.07)
}.scope;
)

//Use MIX
(
{
	Mix.ar(
		[
			Saw.ar(500, 0.05),
			Saw.ar(600, 0.06),
			Saw.ar(700, 0.07)
		]
	)
}.scope;
)

//Mix.arFill
{Mix.arFill(3, {|i| Saw.ar(500 + (i*100), 0.05)})}.scope;

//Scaling = multiplication
{WhiteNoise.ar(0.1) * SinOsc.kr(1, 1)}.scope;

(
{
	(WhiteNoise.ar(0.1) * SinOsc.kr(1, 1))
	*
	(BrownNoise.ar(0.1) * SinOsc.kr(2, 1))
}.scope(zoom: 2000);
)

//Envelopes
{ SinOsc.ar(440, 0, 0.1) * EnvGen.kr(Env.sine(1), doneAction: Done.freeSelf)}.scope;

//Keyword arguments
(
SynthDef("timeScale", {
	|ts=1|
	Out.ar(
		0,
		SinOsc.ar(440, 0, 0.4)
		*
		EnvGen.kr(
			Env.sine(1),
			doneAction: Done.freeSelf,
			timeScale: ts
		)
	)
}).add;
)

Synth("timeScale", [\ts, 0.1]) //timeScale controls the duration of the envelope

(
r = Routine({
	loop({
		Synth("timeScale", [\ts, 0.01.rrand(0.3)]);
		0.5.wait;
	})
});
)
r.play;
r.stop;


//Additive Synthesis
(
{
	var n = 12;
	Mix.arFill(
		n,
		{
			SinOsc.ar(
				[67.0.rrand(2000), 67.0.rrand(2000)],
				0,
				n.reciprocal * 0.75
			)
		}
	)
	*
	EnvGen.kr(Env.perc(11, 6), doneAction: Done.freeSelf)
}.scope;
)

//Envelopes
(
{
	var n = 12;
	Mix.arFill(
		n,
		{
			SinOsc.ar(
				[67.0.rrand(2000), 67.0.rrand(2000)],
				0,
				n.reciprocal
			)
			*
			EnvGen.kr(
				Env.sine(2.0.rrand(17)),
				doneAction: Done.none
			)
		}
	)
	*
	EnvGen.kr(
		Env.perc(11, 6),
		doneAction: Done.freeSelf,
		levelScale: 0.75
	)
}.scope;
)

//Klang UGen

//Ring Modulation

{ SinOsc.ar(440, 0, 0.571) * SinOsc.kr(880)}.scope;


//Amplitude Modulation
//use an lfo to modulate the amplitude of the modulator
(
{
	SinOsc.ar(440, 0, 0.571)
	*
	SinOsc.kr(880)
	*
	SinOsc.kr([6.99, 8.01].reciprocal)
}.scope;
)

//classic AM
{SinOsc.ar(440, 0, 0.571) * SinOsc.kr(880).abs}.scope;

//ring
{ SinOsc.ar(440, 0, 0.571) * SinOsc.kr(880) }.scope;



















































