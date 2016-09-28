
/*
(SynthDef(\pi1_synth1, {|freq=330,out=0,gate=1,dur=0.1, amp=0.5|
   Out.ar( out, amp * SinOsc.ar(freq) * EnvGen.kr( Env.perc(1/20,dur), gate, doneAction: 2 ) )

parametre 1 >>> 1 al 30
parMETRO 2 >>> 1 AL 100

*/

//noiseuno panaz
(
SynthDef(\noise1,{
	arg freq1=200,freq2=300, gate=1, dur=100, amp=0.5,out=0, pospan=2.0, width=2.0;
	var env,sig, panaz;
	env = EnvGen.kr(Env.adsr(0.5,0.5,0.5,1),doneAction:2);
	sig =  SinOsc.ar(BrownNoise.ar(freq1, freq2));
	sig = sig * amp * env;
	panaz= PanAz.ar(8,sig,pospan,0.3,width,0.5);
	Out.ar(out,panaz);
}).send(s);
)


a=Synth(\noise1, [\freq1,rrand(100,300),\freq2,rrand(200,400)]);
a.set(\freq1,700);//as integers
a.set(\freq2,400);
a.set(\pospan,0); ///asfloats con cambios de 0.2
a.set(\width,2);
a.free;


///drone 1 panaz
(
~buf2= Buffer.alloc(s, 512,1);
~buf2.sine1(1/Array.fill(10,{|i| i+1}));

SynthDef(\drone1, {|out= 0, gate= 1, amp= 0.25, dur= 0.1,
modFreq=1, freq1=64, freq2=65, mul1=1, mul2=1, pospan=2.0, width=2|
	var env, mod, a, b, mixsig, sig, panaz;
	env = EnvGen.kr(Env.adsr(0.5,0.5,0.5,1),doneAction:2);
	mod = LFTri.ar(modFreq);
	a = Osc.ar (~buf2, freq1,  mod, mul1);
	b = Osc.ar (~buf2, freq2, mod,  mul2);
	mixsig= Mix.new([a,b]);
	sig= mixsig * (env *amp);
	panaz= PanAz.ar(8,sig,pospan,0.5,width,0.5);
	Out.ar(out, panaz);
}).add;
)

b=Synth(\drone1,[\freq1, rrand(60,80),\freq2,rrand(60,80)]);
b.set(\freq1,100);
b.set(\freq2,80);
b.set(\pospan,0.5);
b.set(\freq1,);
b.free;


//synths 1 panaz
(
SynthDef(\synths1, {
	|freq=220, dur=0.1, gate=1, amp=0.5,out=0, pospan=2.0, width=2|
	var env, sig, panaz;
	env = EnvGen.kr(Env.adsr(0.5,0.5,0.5,1),doneAction:2);
	sig = SinOsc.ar([1, 1.334840, 1.587401] * freq, 0, 0.2).sum;
	sig = env * sig * amp;
	panaz = PanAz.ar(8,sig,pospan,0.5,width,0.5);
	Out.ar(out, panaz);
}).add;
)


c=Synth(\synths1);
c.set(\freq,120);
c.set(\pospan,0.5);
c.free;



(
SynthDef(\darkbell,{|out= 0, gate= 1, amp= 0.25, fund=200, pulseFreq=0.5, sus=100, dur=100, pospan=2, width=2|
	var env, sound,sound2, pulse, percEnv, panaz;
	env = EnvGen.ar(Env.asr(0.01, sus, 0.5), gate, doneAction:2);
	sound = Array.fill(10, {SinOsc.ar(fund + Rand(0,200), Rand(0.0,1.0), 10.reciprocal) * EnvGen.ar(Env.perc(0.1, 2+Rand(0.0,dur)))});
	sound= Mix(sound);
	panaz = PanAz.ar(8,sound,pospan,0.5,width,0.5);
Out.ar(out, panaz)
}).add;
)



d=Synth(\darkbell);
d.set(\fund,10);
d.set(\pulseFreq,0.5);
d.set(\pospan,0.5);
d.free;



///

(
SynthDef(\latoo,{
	arg out=0, gate=1, dur=1,freq1=1, freq2=1, freq3=1,freq4=1, pospan=2, width=2;
	var env,sig, mixsig, panaz;
	env = EnvGen.kr(Env.adsr(0.5,0.5,0.5,1),doneAction:2);
	sig = LatoocarfianN.ar(SampleRate.ir/4,
		LFNoise2.kr(freq1,1.5,1.5),
		LFNoise2.kr(freq2,1.5,1.5),
		LFNoise2.kr(freq3,0.5,1.5),
        LFNoise2.kr(freq4,0.5,1.5)) * 0.05 ;
	mixsig = sig * env;
	panaz = PanAz.ar(8,mixsig,pospan,0.5,width,0.5);
	Out.ar(out,panaz);
}).add;
)

p = Synth(\latoo);
p.set(\freq1,4);
p.set(\pospan,0.5);
p.free;
//

(
SynthDef(\basicFM, {
	|out = 0, gate = 1, amp = 0.3, carFreq = 60, modFreq = 80, modAmount = 1000, clipAmount = 0.1, pospan=2, width=2|
		var modEnv = EnvGen.ar(Env.adsr(0.5, 0.5, 0.7, 0.1, peakLevel: modAmount), gate);
		var mod = SinOsc.ar(modFreq) * modEnv;
		var car = SinOsc.ar(carFreq + mod);
		var ampEnv = EnvGen.ar(Env.adsr(0.1, 0.3, 0.7, 0.2, peakLevel: amp), gate, doneAction: 2);
		var clip = clipAmount * 500;
	    var mixsig = (car * ampEnv * clip).clip(-0.7, 0.7);
	    var panaz = PanAz.ar(8,mixsig,pospan,0.5,width,0.5);
		Out.ar(out, panaz * 0.005);
	}).add;
)

o = Synth(\basicFM);
o.set(\carFreq,400);
o.set(\modFreq,500);
o.set(\modAmount,100);
o.set(\clipAmount,50);
o.set(\pospan,0.5);
o.free;
