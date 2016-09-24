
////
(
SynthDef(\panaz8, {
	arg freqini=120, outbus=0;
	var klank;
	klank = Klank.ar(`[(Array.series(4, 1, 1)), (Array.fill(4, 0.05)), (Array.fill(4, 1))], {ClipNoise.ar(0.003)}!8, freqini);
     Out.ar(outbus,PanAz.ar(8,
		(klank), LFSaw.kr(0.5)
                )
        )
}).add;
)

x = Synth(\panaz8);
x.set(\outbus,1);
x.free;



//////

SynthDef(\bass,{ |out, freq=440, sustain=1, gate=1, amp=0.1|
	var snd, env, fenv, harm;
	harm = [1,1.01,2,2.02,3.5,4.01,5.501];
	harm = harm ++ (harm*2);
	snd = SinOsc.ar(freq*harm).sum.distort * 2;
	snd = snd + SinOsc.ar(freq / [1, 2]).sum!2;
	env = EnvGen.kr(Env.adsr(0.001,0.2,0.9,0.25), gate, amp, doneAction:2);
	snd = snd * env;
	OffsetOut.ar(out, (snd!2));
}).play;

Delay1