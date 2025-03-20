{Saw.ar(500, 0.1)}.scope;

{ Formlet.ar(Saw.ar(11), 400, 0.01, 0.11, 0.022)}.scope;

//Groups are linked lists
//Nodes, Linked Lists, Trees

//RootNode and default_group
s.reboot;
s.queryAllNodes;

//new synths are attached by default to the head of the default_group
(
SynthDef("ringModulation", {
	Out.ar(
		0,
		Mix.ar(
			SinOsc.ar([440.067, 441.013], 0, 1)
			*
			SinOsc.ar([111, 109], 0, 0.2)
		)
	)
}).add;
)

Synth("ringModulation");
(
s.queryAllNodes;
)

//Two Synths
(
SynthDef("pitchFromNoise", {
	|out=0|
	Out.ar(
		out,
		Resonz.ar(
			WhiteNoise.ar(15),
			LFNoise0.kr(20, 110, 660),
			0.005
		)
	)
}).add;
)

Synth("ringModulation");
Synth("pitchFromNoise", [\out, 1]);
(
s.queryAllNodes;
)

(
SynthDef("firstNode-source", {
	Out.ar(
		0,
		Saw.ar([200, 201], 0.05)
	)
}).add;

SynthDef("secondNode-filter", {
	ReplaceOut.ar(
		0,
		LPF.ar(
			In.ar(0, 2),
			Lag.kr(
				LFNoise0.kr([4, 4.001], 500, 1000),
				0.1
			)
		)
	)
}).add;
)

//evaluate "secondNode-filter" first
//"firstNode-source" will go at the head of default_node
(
Synth("secondNode-filter");
Synth("firstNode-source");
)

//use .head and .tail to attach nodes to default_group
(
Synth.head(s, "firstNode-source");
Synth.tail(s, "secondNode-filter");
)

(
s.queryAllNodes;
)

//assign synths to groups
(
~source = Group.head(s);
~effect = Group.tail(s);
)

(
//add the synths to the appropriate groups
Synth.head(~effect, "secondNode-filter");
Synth.tail(~source, "firstNode-source");
)

//the idea is that the groups are attached first to the default_group in the desired order
//the synths can then be evaluated in any order as long as they're attached to the appropriate group

(
s.queryAllNodes;
)

//set a control for all of the synths in a group

(
SynthDef("synthNumber1", {
	|mul=0.2|
	Out.ar(
		0,
		BrownNoise.ar(mul) * LFNoise0.kr([1, 1.01])
	)
}, [0.1]).add;
SynthDef("synthNumber2", {
	|mul=0.2|
	Out.ar(
		0,
		WhiteNoise.ar(mul) * LFNoise0.kr([2.99, 3])
	)
}, [0.1]).add;
SynthDef("synthNumber3", {
	|mul=0.2|
	Out.ar(
		0,
		PinkNoise.ar(mul) * LFNoise2.kr([0.79, 0.67])
	)
}, [0.1]).add;
)

(
//make a group
~myGroup = Group.new;
)

(
//attach 3 synths
Synth.head(~myGroup, "synthNumber1");
Synth.head(~myGroup, "synthNumber2");
Synth.head(~myGroup, "synthNumber3");
)

//set the \mul control of each of the 3 synths in the group
~myGroup.set(\mul, 0.01.rrand(0.2))

(
s.queryAllNodes;
)



















































