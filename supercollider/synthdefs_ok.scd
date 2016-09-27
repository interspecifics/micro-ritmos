
/*
(SynthDef(\pi1_synth1, {|freq=330,out=0,gate=1,dur=0.1, amp=0.5|
   Out.ar( out, amp * SinOsc.ar(freq) * EnvGen.kr( Env.perc(1/20,dur), gate, doneAction: 2 ) )

parametre 1 >>> 1 al 30
parMETRO 2 >>> 1 AL 100

*/


(
SynthDef(\noise1,{
	arg freq1=200,freq2=300, gate=1, dur=100, amp=0.5,out=0, pospan=2.0, width=2.0;
	var env,sig, panaz;
	env = EnvGen.kr(Env.perc(1/20,dur), gate, doneAction: 2);
	sig =  SinOsc.ar(BrownNoise.ar(freq1, freq2));
	sig = sig * amp * env;
	panaz= PanAz.ar(8,sig,pospan,0.3,width,0.5);
	Out.ar(out,panaz);
}).send(s);
)


a=Synth(\noise1, [\Freq1,rrand(100,300),\freq2,rrand(200,400)]);
a.set(\pospan,0); ///asfloats con cambios de 0.2
a.set(\width,2);



(
SynthDef(\panaz2) {
	arg noise=0.3, width = 2.0;
    var panaz;
	panaz = PanAz.ar(
        8,                 // numChans
        ClipNoise.ar,     // in
        LFSaw.kr(LFNoise1.kr(noise)),0.01,width,0.5);
	Out.ar(0,panaz);
}.add
)



(
~buf2= Buffer.alloc(s, 512,1);
~buf2.sine1(1/Array.fill(10,{|i| i+1}));

SynthDef(\drone1, {|out= 0, gate= 1, amp= 0.25, dur= 0.1,
modFreq=1, freq1=64, freq2=65, mul1=1, mul2=1|
	var env, mod, a, b, mixer;
	env = EnvGen.kr(Env.perc(1/20,dur), gate, doneAction: 2);
	mod = LFTri.ar(modFreq);
	a = Osc.ar (~buf2, freq1,  mod, mul1);
	b = Osc.ar (~buf2, freq2, mod,  mul2);
	mixer= Mix.new([a,b]);
	Out.ar(out, mixer * (env *amp));
}).add;
)


b=Synth(\drone1,[\freq1, rrand(60,80),\freq2,rrand(60,80)]);




(
SynthDef(\synths1, {
	|freq=440, dur=0.1, gate=1, amp=0.5,out=0|
	var env, sig;
	env = EnvGen.kr(Env.perc(1/20,dur), gate, doneAction: 2);
	sig = SinOsc.ar([1, 1.334840, 1.587401] * freq, 0, 0.2).sum;
	Out.ar(out, env * sig * amp);
}).add;
)


c=Synth(\synths1,[\freq, rrand(45,80).midicps]);


(
SynthDef(\darkbell,{|out= 0, gate= 1, amp= 0.25, fund=200, pulseFreq=0.5, sus=100, dur=100|
	var env, sound,sound2, pulse, percEnv;
	env = EnvGen.ar(Env.asr(0.01, sus, 0.5), gate, doneAction:2);
	sound = Array.fill(10, {SinOsc.ar(fund + Rand(0,200), Rand(0.0,1.0), 10.reciprocal) * EnvGen.ar(Env.perc(0.1, 2+Rand(0.0,dur)))});
	sound= Mix(sound);
Out.ar(out, sound )
}).play;
)



d=Synth(\darkbell);
d.set(\fund,10);
d.set(\pulseFreq,0.5);


///

(
SynthDef(\Latton,{
	arg out=0, gate=1, dur=1,freq1=1, freq2=1, freq3=1,freq4=1;
	var env,sig;
	env = EnvGen.kr(Env.perc(1/20,dur), gate, doneAction: 2);
	sig = LatoocarfianN.ar(SampleRate.ir/4,
		LFNoise2.kr(freq1,1.5,1.5),
		LFNoise2.kr(freq2,1.5,1.5),
		LFNoise2.kr(freq3,0.5,1.5),
        LFNoise2.kr(freq4,0.5,1.5)) * 0.2 ;
	Out.ar(out,sig * env);
}).play;
)

//

(
SynthDef(\basicFM, {
	|out = 0, gate = 1, amp = 1, carFreq = 60, modFreq = 80, modAmount = 1000, clipAmount = 0.1|
		var modEnv = EnvGen.ar(Env.adsr(0.5, 0.5, 0.7, 0.1, peakLevel: modAmount), gate);
		var mod = SinOsc.ar(modFreq) * modEnv!8;
		var car = SinOsc.ar(carFreq + mod);
		var ampEnv = EnvGen.ar(Env.adsr(0.1, 0.3, 0.7, 0.2, peakLevel: amp), gate, doneAction: 2);
		var clip = clipAmount * 500;
		Out.ar(out, (car * ampEnv * clip).clip(-0.7, 0.7) * 0.1);
	}).play;

)

