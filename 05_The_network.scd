s = Server("aServer", NetAddr("127.0.0.1", 56789));
s.boot;

(
SynthDef("sine", {
	Out.ar(0, SinOsc.ar(440, 0, 0.2))
}).send(s);
)
s.sendMsg("s_new", "sine", n = s.nextNodeID, 0, 1);
s.sendMsg("/n_free", n);

s.quit;