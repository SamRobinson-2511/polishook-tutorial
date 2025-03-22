//2 synthdefs - the 1st to make the grains and the 2nd to delay them

(
SynthDef("someGrains", {
	|centerFreq=777, freqDev=200, grainFreq=2|
	var gate;
	gate = Impulse.kr(grainFreq);
	Out.ar(
		0,
		SinOsc.ar(
			LFNoise0.kr(4, freqDev, centerFreq),
			0,
			EnvGen.kr(Env.sine(0.1), gate, 0.1)
		)
	)
}).add;

SynthDef("aDelay", {
	|delay = 0.25|
	Out.ar(
		1,
		DelayN.ar(
			In.ar(0, 1),
			delay,
			delay
		)
	)
}).add;
)

Synth("someGrains");

(
~source = Group.head(s);
~effects = Group.tail(s);
)

(
Synth.head(~source, "someGrains");
Synth.head(~effects, "aDelay");
)

//Comb example
(
{
	CombN.ar(
		SinOsc.ar(500.rrand(1000), 0, 0.2) * Line.kr(1, 0, 0.1),
		0.3,
		0.25,
		6
	)
}.scope;
)

(
{
	AllpassN.ar(
		SinOsc.ar(500.rrand(1000), 0, 0.2) * Line.kr(1, 0, 0.1),
		0.3,
		0.25,
		6
	)
}.scope;
)

(
{
	CombN.ar(
		SinOsc.ar(500.rrand(1000), 0, 0.2)*Line.kr(1, 0, 0.1),
		0.1,
		0.025,
		6
	)
}.scope;
)

(
{
	AllpassN.ar(
		SinOsc.ar(500.rrand(1000), 0, 0.2) * Line.kr(1, 0, 0.1),
		0.1,
		0.025,
		6
	)
}.scope;
)


//Reverberation
(
{
	var s, z, y;
	s = Mix.ar(Array.fill(10, {Resonz.ar(Dust.ar(0.2, 50), 200 + 3000.0.rand, 0.003)}));
	z = DelayN.ar(s, 0.048);
	y = Mix.ar(Array.fill(7, {CombL.ar(z, 0.1, LFNoise1.kr(0.1.rand, 0.04, 0.05), 15)}));
	4.do({ y = AllpassN.ar(y, 0.050, [0.050.rand, 0.050.rand], 1)});
	s+(0.2*y)
}.scope;
)
