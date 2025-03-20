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














