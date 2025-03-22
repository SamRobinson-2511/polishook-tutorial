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


//Reverberation: JMC SC2
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

(
SynthDef("filteredDust", {
	Out.ar(
		2,
		Mix.arFill(10, { Resonz.ar(Dust.ar(0.2, 50), Rand(200, 3200), 0.003)})
	)
}).add;

SynthDef("preDelay", {
	ReplaceOut.ar(
		4,
		DelayN.ar(In.ar(2, 1), 0.048, 0.048)
	)
}).add;

SynthDef("combs", {
	ReplaceOut.ar(
		6,
		Mix.arFill(7, { CombL.ar(In.ar(4, 1), 0.1, LFNoise1.kr(Rand(0, 0.1), 0.04, 0.05),
			15)})
	)
}).add;

SynthDef("allpass", {
	|gain = 0.2|
	var source;
	source = In.ar(6, 1);
	4.do({ source = AllpassN.ar(source, 0.050, [Rand(0, 0.05), Rand(0, 0.05)], 1)});
	ReplaceOut.ar(
		8,
		source*gain
	)
}).add;

SynthDef("theMixer", {
	|gain = 1|
	ReplaceOut.ar(
		0,
		Mix.ar([In.ar(2, 1), In.ar(8, 2)]) * gain
	)
}).add;
)

(
Synth.tail(s, "filteredDust");
Synth.tail(s, "preDelay");
Synth.tail(s, "combs");
Synth.tail(s, "allpass");
Synth.tail(s, "theMixer");
)

(
s.queryAllNodes;
)


//or use groups to control the order of execution
(
~source = Group.tail(s);
~proc1 = Group.tail(s);
~proc2 = Group.tail(s);
~proc3 = Group.tail(s);
~final = Group.tail(s);
)

(
Synth.head(~final, "theMixer");
Synth.head(~proc3, "allpass");
Synth.head(~proc2, "combs");
Synth.head(~proc1, "preDelay");
Synth.head(~source, "filteredDust");
)

(
s.queryAllNodes;
)













