//* Micro-ritmos. MAMM 2016

//inicio
(
o = Server.local.options; ////variable para cambios en el servidor
o.numOutputBusChannels = 8; //setea 8 canales 8 de salida ANTES DE BOOTEAR!!
o.numOutputBusChannels.postln;/// imprime canales de salida habilitados
o.device = "MOTU 896mk3 Hybrid"; //setea tarjeta de audio
o.outDevice.postln; //imprimir dispositivo de salida
s.boot; ///bootear servidos
)


////RASPI1
(

SynthDef(\uno,{
	arg freq=60, nharm=20, detune=0.5,amp=0.4,out=0;
	var sig, env;
	env = EnvGen.kr(Env.adsr(0.5,0.5,0.5,1),doneAction:2);
	sig = Blip.ar(
		freq *
		LFNoise1.kr(0.2!8).bipolar(detune.neg,detune).midiratio,nharm);
	sig = sig * LFNoise1.kr(0.4!8).exprange(0.1,1);
	sig = (sig * env * amp);
	Out.ar(out,sig);

}).add;
)
e = Synth.new(\uno);
e.set(\amp,0.6);///checar cumplea
e.free;



(
f = OSCFunc( { | msg, time, addr, port |
	var pyFreq,pyNharm,pyDetune,pyOut;
	pyFreq = msg[1]+1*30; //valores originales del 0 al 5
	pyNharm = msg[2]; //valores originales del 1 al 30
	pyDetune = msg[3]/2.5;//valores originales del 1 al 100 milisegundos
	pyOut = msg[4];//valores originales del 1 al 8
	( "/raspi1/freq is " + pyFreq ).postln;
	( "/raspi1/nharm " + pyNharm ).postln;
	( "/raspi1/detune " + pyDetune ).postln;
	//( "/raspi1/channel is " + pyOut).postln;
	e.set(\freq,pyFreq, \nharm,pyNharm, \detune,pyDetune,
		 );
}, '/raspi1/' );
)

f.free;



(
SynthDef(\noise1,{
	arg freq1=200,freq2=300, gate=1, dur=100, amp=0.5,out=0, pospan=2.0, width=2.0;
	var env,sig, panaz;
	env = EnvGen.kr(Env.perc(1/20,dur), gate, doneAction: 2);
	sig =  SinOsc.ar(BrownNoise.ar(freq1, freq2));
	sig = sig * amp * env;
	panaz= PanAz.ar(8,sig,pospan,0.3,width,0.5);
	Out.ar(out,panaz);
}).add;
)


a=Synth(\noise1, [\Freq1,rrand(100,300),\freq2,rrand(200,400)]);
a.set([\freq]
a.set(\pospan,0.1); ///asfloats con cambios de 0.2
a.set(\width,1);
a.free;



(
d= OSCFunc( { | msg, time, addr, port |
	var pyFreq,pyNharm,pyDetune,pyOut;
	pyFreq = msg[1]+1*30; //valores originales del 0 al 5
	pyNharm = msg[2]; //valores originales del 1 al 30
	pyDetune = msg[3]/2.5;//valores originales del 1 al 100 milisegundos
	pyOut = msg[4];//valores originales del 1 al 8
	( "/raspi1/freq is " + pyFreq ).postln;
	( "/raspi1/nharm " + pyNharm ).postln;
	( "/raspi1/detune " + pyDetune ).postln;
	//( "/raspi1/channel is " + pyOut).postln;
	e.set(\freq,pyFreq, \nharm,pyNharm, \detune,pyDetune,
		 );
}, '/raspi1/' );
)


)


///RASP2
(
SynthDef(\panaz2, {
	arg noise=0.3, width = 2.0;
    var panaz;
	panaz = PanAz.ar(
        8,
        ClipNoise.ar,
        LFSaw.kr(LFNoise1.kr(noise)),0.01,width,0.5);
	Out.ar(0,panaz);
}).add
)
g=Synth(\panaz2);
g.set(\noise,2);
g.set(\width,1);
g.free;

(
h = OSCFunc( { | msg, time, addr, port |
	var pyNoise,pyWidth;
	pyNoise = msg[1]+1.midiratio; //valores originales del 0 al 5
	//pyFreq = msg[2]/15; //valores originales del 1 al 30
	//pyDetune = msg[3]/2.5;//valores originales del 1 al 100 milisegundos
	pyWidth = msg[4]+1;//valores originales del 1 al 8
	( "/raspi2/noise is " + pyNoise ).postln;
	( "/raspi2/width is " + pyWidth).postln;
	//( "detune " + pyDetune ).postln;
	//( "channel is " + pyOut).postln;
	g.set(\noise,pyNoise,\width,pyWidth);
}, '/raspi2/' );
)
h.free


(
SynthDef.new(\pulseTest, {
	arg ampHz=4, fund=20, maxPartial=4, width=0.5;
	var amp1, amp2, freq1, freq2, sig1, sig2,mixer;
	amp1 = LFPulse.kr(ampHz, 0, 0.12) * 0.1;
	amp2 = LFPulse.kr (ampHz, 0.5, 0.12) * 0.1;
	freq1 = LFNoise0.kr(4).exprange(fund, fund*maxPartial).round(fund);
	freq2 = LFNoise0.kr(4).exprange(fund, fund*maxPartial).round(fund);
	freq1 = freq1 * LFPulse.kr(8, add:1);
	freq2 = freq2 * LFPulse.kr(6, add:1);
	sig1 = Pulse.ar(freq1, width, amp1);
	sig2 = Pulse.ar (freq2, width, amp2);
	sig1 = FreeVerb.ar(sig1, 0.7, 0.8, 0.25);
	sig2 = FreeVerb.ar(sig2, 0.7, 0.8, 0.25);
	mixer = Mix.new([sig1,sig2!8]);
	Out.ar (0, mixer);
}).add;
)



x = Synth.new(\pulseTest;);
x.set(\width, 0.1);
x.set(\fund, 20);
x.set(\maxPartial, 2);
x.set(\ampHz, 1);
x.free;

(
j = OSCFunc( { | msg, time, addr, port |
	var pyPart,pyWidth,pyFund,piAmphz;
	pyPart = msg[1]+1*2; //valores originales del 0 al 5
	piAmphz = msg[1].rrand(1,7);
	pyFund = msg[2].rrand(30,50); //valores originales del 1 al 30
	//piAmphz = msg[3]/2.5;//valores originales del 1 al 100 milisegundos
	pyWidth = msg[4]/2.asFloat.rrand(0.1,1);//valores originales del 1 al 8
	( "/raspi2/partial is " + pyPart ).postln;
	( "/raspi2/hz is " + piAmphz ).postln;
	( "/raspi2/fundamental is " + pyFund ).postln;
	( "/raspi2/width is " + pyWidth).postln;
	x.set(\maxPartial,pyPart,\ampHz,piAmphz,\fund,pyFund,\width,pyWidth);
}, '/raspi2/' );
)
j.free


///RASP3


(
    ~buf2= Buffer.alloc(s, 512,1);
	~buf2.sine1(1/Array.fill(10,{|i| i+1}));

SynthDef(\drone1, {|out= 0, gate= 1, amp= 0.15,
modFreq=1, freq1=64, freq2=65, mul1=0.09, mul2=0.09|
	var env, mod, a, b, mixer;
	env = EnvGen.ar(Env.asr(0.01, 1, 0.5), gate, doneAction:2);
	mod = LFTri.ar(modFreq);
	a = Osc.ar (~buf2, freq1,  mod, mul1)!8;
	b = Osc.ar (~buf2, freq2, mod,  mul2)!8;
	mixer= Mix.new([a,b]);
	Out.ar(out, mixer * (env *amp));
}).add;
)


g = Synth(\drone1);
g.set(\amp,0.25);
g.free;

(
i = OSCFunc( { | msg, time, addr, port |
	var pymodFreq,pyFreq1,pyFreq2;
	pymodFreq = msg[1]; //valores originales del 0 al 5
	pyFreq1 = msg[2]*5; //valores originales del 1 al 30
	pyFreq2 = msg[3].asFloat/5;//valores originales del 1 al 100 milisegundos
	//py = msg[4];//valores originales del 1 al 8
	( "/raspi3/modFreq " + pymodFreq ).postln;
	( "/raspi3/freq1 " + pyFreq1 ).postln;
	( "/raspi3/freq2 " + pyFreq2 ).postln;
	//( "channel is " + pyOut).postln;
	g.set(\modFreq,pymodFreq, \freq1,pyFreq1, \freq2,pyFreq2
		 );
}, '/raspi3/' );
)
i.free
)






