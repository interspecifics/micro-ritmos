(
OSCdef.new(
	\toggle,
	{
		arg msg, time, addr, port;
		x.set(\gate, msg[1]);

	},
	'/1/toggle1'
);

OSCdef.new(
	\fader1,
	{
		arg msg, time, addr, port;
		x.set(\freq, msg[1].linexp(0,1,20,500));
	},
	'/1/fader1'
);

OSCdef.new(
	\fader2,
	{
		arg msg, time, addr, port;
			x.set(\nharm, msg[1].linlin(0,1,1,50));
	},
	'/1/fader2'
);
OSCdef.new(
	\fader3,
	{
		arg msg, time, addr, port;
		x.set(\amp, msg[1].linexp(0,1,0.001,1));
	},
	'/1/fader3'
);

OSCdef.new(
	\rotary1,
	{
		arg msg, time, addr, port;
		x.set(\pan, msg[1].linlin(0,1,-1,1));
	},
	'/1/rotary1'
);

OSCdef.new(
	\rotary2,
	{
		arg msg, time, addr, port;
		x.set(\detune, msg[1].linexp(0,1,0.01,12));
	},
	'/1/rotary2'
);

)


(
SynthDef.new(\tone,{
	arg freq=40, nharm=12, detune=0.2, gate=0, pan=0,
	amp=1, out=0;
	var sig, env;
	env = EnvGen.kr(Env.adsr(0.05,0.1,0.5,3),gate);
	sig = Blip.ar(
		freq *
		LFNoise1.kr(0.2!8).bipolar(detune.neg,detune).midiratio,nharm
	);
	sig = sig * LFNoise1.kr(0.5!8).exprange(0.1,1);
	sig = Splay.ar(sig); //lo hace stereo quitar para multicanal
	sig = Balance2.ar(sig[0], sig[1], pan);
	sig = sig * env * amp;
	Out.ar(out,sig);
}).add
)

x = Synth.new(\tone);
x = Synth.new(\tone,[\gate,1]);

x.set(\freq, 100);
x.set(\nharm, 2);
x.set(\detune, 2);
x.set(\amp, 2);
x.set(\pan, 0);
x.free;

