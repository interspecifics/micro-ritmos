
////con outbus variable pero clipea no se puede usar para cambiar de canal
(
SynthDef(\panaz8, {
	arg freqini=120, outbus=0, amp=0.5, freq=0.5;
	var klank,env;
	env = EnvGen.kr(Env.pairs([[1, 1], [2.1, 0.5],  [3, 0.5]], \exp));
	klank = Klank.ar(`[(Array.series(4, 1, 1)), (Array.fill(4, 0.05)), (Array.fill(4, 1))], {ClipNoise.ar(0.0009)}!8, freqini);
     Out.ar(outbus,(PanAz.ar(7,
		(klank), LFSaw.kr(freq))*env*amp
                )
        )
}).add;
)

x = Synth(\panaz8);
x.set(\outbus,1);
x.set(\amp,4);
x.set(\freq,0.5);
x.free;


///

(
a = {
    PanAz.ar(
        8,                 // numChans
        ClipNoise.ar,     // in
        LFSaw.kr(LFNoise1.kr(0.3).unipolar),0.01,2,0.5
    );
}
)
a.play;
