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

///prueba de bocinas una por una
p = ProxySpace.push;
~test1 = { SinOsc.ar([1] * 100) * 0.1 };
~test1.play(1); //aqui número de bocina
~test1.stop


////RASPI1
(

SynthDef(\uno,{
	arg freq=80, nharm=20, detune=0.5,amp=0.04,out=0;
	var sig, env;
	env = EnvGen.kr(Env.adsr(0.05,0.1,0.5,3),doneAction:2);
	sig = Blip.ar(
		freq *
		LFNoise1.kr(0.2!8).bipolar(detune.neg,detune).midiratio,nharm);
	sig = sig * LFNoise1.kr(0.5!8).exprange(0.1,1);
	sig = (sig * env * amp);
	Out.ar(out,sig);

}).add;
)
e = Synth.new(\uno)
e.set(\amp,0.5);
e.free;


(
f = OSCFunc( { | msg, time, addr, port |
	var pyFreq,pyNharm,pyDetune,pyOut;
	pyFreq = msg[1]+1*50;
	pyNharm = msg[2]/2;
	pyDetune = msg[3];
	pyOut = msg[4];
	( "freq is " + pyFreq ).postln;
	( "nharm " + pyNharm ).postln;
	( "detune " + pyDetune ).postln;
	( "channel is " + pyOut).postln;
	e.set(\freq,pyFreq, \nharm,pyNharm, \detune,pyDetune, \out, pyOut,
		 );
}, '/raspi1/' );
)
f.free






