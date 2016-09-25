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
	arg freq=60, nharm=20, detune=0.5,amp=0.5,out=0;
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
e.set(\amp,0.7);
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
	( "/raspi1/channel is " + pyOut).postln;
	e.set(\freq,pyFreq, \nharm,pyNharm, \detune,pyDetune, \out, pyOut,
		 );
}, '/raspi1/' );
)

f.free;

)


///RASP2
(
SynthDef(\panaz8, {
	arg freqini=120, outbus=0, amp=3, freq=0.5;
	var klank,env;
	env = EnvGen.kr(Env.pairs([[1, 1], [2.1, 0.5],  [3, 0.5]], \exp));
	klank = Klank.ar(`[(Array.series(4, 1, 1)), (Array.fill(4, 0.05)), (Array.fill(4, 1))], {ClipNoise.ar(0.0009)}!8, freqini);
     Out.ar(outbus,(PanAz.ar(7,
		(klank), LFSaw.kr(freq))*env*amp
                )
        )
}).add;
)

g = Synth(\panaz8);
g.set(\amp,7);
g.free;

(
h = OSCFunc( { | msg, time, addr, port |
	var pyFreq,pyNharm,pyDetune,pyOut;
	//pyOut = msg[1]; //valores originales del 0 al 5
	pyFreq = msg[2]/15; //valores originales del 1 al 30
	//pyDetune = msg[3]/2.5;//valores originales del 1 al 100 milisegundos
	//pyOut = msg[4];//valores originales del 1 al 8
	( "/raspi2/freq is " + pyFreq ).postln;
	//( "/raspi1/bus " + pyOut ).postln;
	//( "detune " + pyDetune ).postln;
	//( "channel is " + pyOut).postln;
	g.set(\freq,pyFreq,
		 );
}, '/raspi2/' );
)
h.free


///RASP3


(
g= {
    PanAz.ar(
        8,                 // numChans
        ClipNoise.ar,     // in
        LFSaw.kr(LFNoise1.kr(0.3).unipolar),0.01,2,0.5
    );
}
)
g.play;


(
g = Synth.new(\pruebapara3);


(
i = OSCFunc( { | msg, time, addr, port |
	var pyRange,pyFreq,pySust,pyOut;
	//pyRange = msg[1]+1*10; //valores originales del 0 al 5
	pyFreq = msg[2]*10; //valores originales del 1 al 30
	pySust = msg[3]/5;//valores originales del 1 al 100 milisegundos
	pyOut = msg[4];//valores originales del 1 al 8
	( "range is " + pyRange ).postln;
	( "freq is " + pyFreq ).postln;
	( "sustain is " + pySust ).postln;
	( "channel is " + pyOut).postln;
	g.set(\freq,pyFreq, \sustain,pySust, \out, pyOut,
		 );
}, '/raspi3/' );
)
i.free
)






