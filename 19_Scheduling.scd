//Routines

r = Routine.({ "hello world".yield.postln});
r.next;
r.next;

r.next;
r.reset;
r.next;

(
r = Routine({
	"hello, world".yield;
	"what a world".yield;
	"i am a world".yield;
})
)
r.next;
r.next;
r.next;
r.next;

r.reset;

r.next;
r.next;
r.next;
r.next;

(
r = Routine({
	var array;
	array = ["hello world", "what a world", "i am a world"];
	3.do({array.choose.yield});
});
)

4.do({r.next.postln});


//Scheduling Routines
(
r = Routine({
	var array;
	array = ["hello world", "what a world", "i am a world"];
	3.do({
		1.wait;
		array.choose.postln;
	})
});
)

r.play;
r.reset;

r.reset.play;

//Clocks and the convenience of .play

SystemClock // the most accurate
AppClock //for use with GUIs
TempoClock //to schedule in beats



//Scheduling synths with routines
(
SynthDef("fm2", {
	|bus=0, freq=440, carPartial=1, modPartial=1, index=3, mul=0.2, ts=1|
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
		car * EnvGen.kr(Env.sine(1), doneAction: Done.freeSelf, timeScale: ts)
	)
}).add;
)

(
r = Routine({
	12.do({
		Synth("fm2",
			[
				\bus, 2.rand, \freq, 400.0.rrand(1200),
				\carPartial, 0.5.rrand(2), \ts, 0.5.rrand(11)
			]
		);
		s.queryAllNodes;
		"".postln.postln.postln.postln.postln;
		2.wait;
	})
})
)

r.reset.play;

//process synths spawned in a routine through effects that run outside of the routine
(
SynthDef("echoplex",{
	ReplaceOut.ar(
		0,
		CombN.ar(
			In.ar(0, 1),
			0.35,
			[Rand(0.005, 0.3), Rand(0.05, 0.3)],
			7,
			0.5
		)
	)
}).add;


~source = Group.head(s);
~effect = Group.tail(s);

r = Routine({
	loop({
		Synth.head(
			~source,
			"fm2",
			[
				\outbus, 0, \freq, 40.0.rrand(1200), \modPartial, 0.75.rrand(2.0),
				\carPartial, 0.5.rrand(11), \ts, 0.1.rrand(0.2)
			]
		);
		s.queryAllNodes;
		0.5.wait;
	});
});
Synth.head(~effect, "echoplex");
Synth.tail(~effect, "echoplex");
)
r.reset.play;





















)