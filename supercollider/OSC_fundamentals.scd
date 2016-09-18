
NetAddr.localAddr

(
SynthDef(\trialsynth, {
	arg pitch=200;
	var sound = SinOsc.ar(pitch, mul:0.2)!2;
	var linen = Env.linen(0.01, sustainTime:0, releaseTime:1);
	var env = EnvGen.kr(linen, doneAction:2);
	Out.ar(0, sound * env);
}).add;
)

a = Synth(\trialsynth, [pitch:90.rrand(600)]);
a.release;

(
OSCdef(\sensorlisener, {
	arg mMessage;
	Synth(\trialsynth, [pitch:mMessage[1]]);
}, "/salida/datos0/filtrado");
)
a.free;

s.meter;