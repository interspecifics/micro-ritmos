
/*
(SynthDef(\pi1_synth1, {|freq=330,out=0,gate=1,dur=0.1, amp=0.5|
   Out.ar( out, amp * SinOsc.ar(freq) * EnvGen.kr( Env.perc(1/20,dur), gate, doneAction: 2 ) )

parametre 1 >>> 1 al 30
parMETRO 2 >>> 1 AL 100

*/


(
SynthDef(\noise1,{
	arg freq1=200,freq2=300, gate=1, dur=0.1, amp=0.5,out=0;
	var env,sig;
	env = EnvGen.kr(Env.perc(1/20,dur), gate, doneAction: 2);
	sig =  SinOsc.ar(BrownNoise.ar(freq1, freq2));
	sig = sig * amp * env;
	Out.ar(out,sig);
}).send(s);
)


a=Synth(\noise1, [\Freq1,rrand(100,300),\freq2,rrand(200,400)]);




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


