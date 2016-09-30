//  1. SERVIDOR Y VOLUMEN

(
o = Server.local.options;
o.numOutputBusChannels = 8;
o.numOutputBusChannels.postln;
o.device = "MOTU 896mk3 Hybrid";
o.outDevice.postln;
s.boot;

v = s.volume;
v.min;
v.max;
v.volume = rrand(-50, 5);
v.setVolumeRange(-90, 8);
v.mute;
v.unmute;
v.gui.alwaysOnTop_(true);
)



// 2. CARGAR 4 SONIDOS

(
SynthDef(\uno,{|freq=60, nharm=20, detune=0.5,amp=0.4,out=0|
	var sig, env;
	env = EnvGen.kr(Env.adsr(0.5,0.5,0.5,1),doneAction:2);
	sig = Blip.ar(
		freq *
		LFNoise1.kr(0.2!8).bipolar(detune.neg,detune).midiratio,nharm);
	sig = sig * LFNoise1.kr(0.4!8).exprange(0.1,1);
	sig = (sig * env * amp);
	Out.ar(out,sig);
	}).send(s);
)

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

(
SynthDef(\panaz2, {
	arg noise=0.3, width = 2.0;
    var panaz;
	panaz = PanAz.ar(
        8,
        ClipNoise.ar,
        LFSaw.kr(LFNoise1.kr(noise)),0.01,width,0.5);
	Out.ar(0,panaz);
	}).send(s);
)

(
~buf2= Buffer.alloc(s, 512,1);
~buf2.sine1(1/Array.fill(10,{|i| i+1}));

SynthDef(\drone1, {|out= 0, gate= 1, amp= 0.5,
modFreq=1, freq1=64, freq2=65, mul1=0.09, mul2=0.09|
	var env, mod, a, b, mixer;
	env = EnvGen.ar(Env.asr(0.01, 1, 0.5), gate, doneAction:2);
	mod = LFTri.ar(modFreq);
	a = Osc.ar (~buf2, freq1,  mod, mul1)!8;
	b = Osc.ar (~buf2, freq2, mod,  mul2)!8;
	mixer= Mix.new([a,b]);
	Out.ar(out, mixer * (env *amp));
}).send(s);
)



// 2. TOCAR 4 SONIDOS



a = Synth.new(\uno);
b = Synth(\noise1, [\Freq1,rrand(100,300),\freq2,rrand(200,400)]);
c = Synth(\panaz2);
d = Synth(\drone1);


/* IR A TERMINAL PARA ENCEDER RASBPERRIES */

// 3. ENCENDER 4 RESPONDERS

//RESPONDER 1
(
OSCFunc( { | msg, time, addr, port |
	var pyFreq,pyNharm,pyDetune,pyOut;
	pyFreq = msg[1]+1*30; //valores originales del 0 al 5
	pyNharm = msg[2]; //valores originales del 1 al 30
	pyDetune = msg[3]/2.5;//valores originales del 1 al 100 milisegundos
	pyOut = msg[4];//valores originales del 1 al 8
	( "/raspi1/freq is " + pyFreq ).postln;
	( "/raspi1/nharm " + pyNharm ).postln;
	( "/raspi1/detune " + pyDetune ).postln;
	//( "/raspi1/channel is " + pyOut).postln;
	a.set(\freq,pyFreq, \nharm,pyNharm, \detune,pyDetune,
		 );
}, '/raspi1/' );
)

//RESPONDER 2
(
OSCFunc( { | msg, time, addr, port |
	var pyPospan, pyFreq1,pyFreq2;
	//py = msg[1].asFloat; //valores originales del 0 al 5
	pyFreq1 = msg[2].midiratio+200; //valores originales del 1 al 30
	pyFreq2 = msg[2].midiratio+300; //valores originales del 1 al 30
	pyPospan = msg[3].midiratio.exp;//valores originales del 1 al 100 milisegundos
	//pyOut = msg[4];//valores originales del 1 al 8
	( "/raspi1/pospan " + pyPospan ).postln;
	( "/raspi1/freq1 " + pyFreq1 ).postln;
	( "/raspi1/freq2 " + pyFreq2 ).postln;
	//( "/raspi1/channel is " + pyOut).postln;
	b.set(\freq1,pyFreq1, \freq2,pyFreq2, \pospan,pyPospan);
}, '/raspi1/' );
)

//RESPONDER 3

(
OSCFunc( { | msg, time, addr, port |
	var pyNoise,pyWidth;
	pyNoise = msg[2].midiratio+1; //valores originales del 1 al 30
	pyWidth = msg[3].midiratio;//valores originales del 1 al 100 milisegundos
	( "/raspi2/noise is " + pyNoise ).postln;
	( "/raspi2/width is " + pyWidth).postln;
	c.set(\noise,pyNoise,\width,pyWidth);
}, '/raspi2/' );
)

//RESPONDER 4

(
OSCFunc( { | msg, time, addr, port |
	var pymodFreq,pyFreqd1,pyFreqd2,pyPospan;
	pymodFreq = msg[1]+1; //valores originales del 0 al 5
	pyFreqd1 = msg[2]*2; //valores originales del 1 al 30
	pyFreqd2 = msg[2]*4;
	pyPospan = msg[3].midiratio.rand(25);//valores originales del 1 al 100 milisegundos
	//pyP = msg[4];//valores originales del 1 al 8
	( "/raspi3/modFreq " + pymodFreq ).postln;
	( "/raspi3/freqd1 " + pyFreqd1 ).postln;
	( "/raspi3/freqd2 " + pyFreqd2 ).postln;
	( "/raspi3/pospan " + pyPospan ).postln;
	//( "channel is " + pyOut).postln;
	d.set(\modFreq,pymodFreq, \freqd1,pyFreqd1, \freqd2,pyFreqd2, \pospan,pyPospan
		 );
}, '/raspi3/' );
)
