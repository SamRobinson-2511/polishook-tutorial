s.reboot;

(
b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");
//mono sample player
SynthDef("aMonoSamplePlayer", { arg bus = 0, bufnum = 0, rateScale = 1;
    Out.ar(
        bus,
        PlayBuf.ar(
            1,
            bufnum,
            BufRateScale.kr(bufnum) * rateScale
        )
        *
        EnvGen.kr(Env.triangle(BufDur.kr(bufnum)))
    )
}).add;
)

(
Synth("aMonoSamplePlayer", [\bus, 0, \bufnum, b]);
)


(
Synth("aMonoSamplePlayer", [\bus, 0, \bufnum, b, \rateScale, 0.25]);
Synth("aMonoSamplePlayer", [\bus, 0, \bufnum, b, \rateScale, 0.5]);
Synth("aMonoSamplePlayer", [\bus, 1, \bufnum, b, \rateScale, 0.75]);
Synth("aMonoSamplePlayer", [\bus, 1, \bufnum, b, \rateScale, 1.5]);
)


//Information
InfoUGenBase.dumpClassSubtree;

BufInfoUGenBase.dumpClassSubtree;

//Loop a sample
(
//read a soundfile
b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");
//define a sample player that will loop over a soundfile
SynthDef("aLoopingSampler", {
	|outBus=0, bufnum=0, rateScale=1, mul=1|
	Out.ar(
		outBus,
		PlayBuf.ar(
			1,
			bufnum,
			BufRateScale.kr(bufnum) * rateScale + LFNoise0.kr(2.reciprocal, 0.05),
			loop: 1
		)
		*
		mul
	)
}).add;
)

//apply amplitude modulation to an audio source
(
SynthDef("ampMod", {
	|inBus=0, outBus=0, modFreq=1|
	Out.ar(
		outBus,
		[
			In.ar(inBus, 1) * SinOsc.kr(modFreq),
			In.ar(inBus, 1) * SinOsc.kr(modFreq = 0.02)
		]
	)
}).add;

//apply a low pass filter to an audio source
SynthDef("aLowPassFilter", {
	|inBus=0, outBus=0, freq=50, freqDev=50, boost=1|
	Out.ar(
		outBus,
		RLPF.ar(
			In.ar(inBus, 2),
			Lag.kr(LFNoise0.kr(1, freqDev, freq), 1),
			0.2
		)
		*
		boost
		*
		LFPulse.kr(1, [0.50, 0.75], [0.5, 0.45])
		+
		In.ar(inBus, 2)
	)
}).add;
)

(
~source = Group.head(s);
~effect = Group.tail(~s);
)

(
//add the sample player to the source group
~theSource = Synth.head(
	~source,
	"aLoopingSampler", [\outBus, 3, \bufNum, b, \rateScale, 1, \mul, 0.051]);
//add amplitude mod synth to head of efx group
~fx1 = Synth.head(
	~effect,
	"ampMod", [\inBus, 3, \outBus, 5, \modFreq, 1]);
~fx2 = Synth.tail(
	~effect,
	"aLowPassFilter", [\inBus, 5, \outBus, 0, \boost, 5])
)

(
s.queryAllNodes;
)

(
~theSource.set(\rateScale, 0.95.rrand(1.05), \mul, 0.051.rrand(0.07));
~fx1.set(\modFreq, 800.0.rrand(1200));
~fx2.set(\freq, 500.rrand(700), \freqDev, 180.rrand(210), \boost, 7);
)





