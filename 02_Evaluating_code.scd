//Evaluating Code
s.boot;
(
{
	SinOsc.ar([400, 401], 0, 0.1) *
	Saw.ar([11, 33], 1) *
	EnvGen.kr(Env.sine(10))
}.play;
)

(
{
	RLPF.ar(
		in: Saw.ar([100, 102], 0.15),
		freq: Lag.kr(LFNoise0.kr(4, 700, 1100), 0.1),
		rq: 0.05
	)
}.play;
)

//Scoping Sound
