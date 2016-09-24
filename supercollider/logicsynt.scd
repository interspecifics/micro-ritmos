

// Configuration *******************************************************
//gui button for iniciate signal
(
o = Server.local.options; ////variable para cambios en el servidor
o.numOutputBusChannels = 8; //setea 8 canales 8 de salida ANTES DE BOOTEAR!!
o.numOutputBusChannels.postln;/// imprime canales de salida habilitados
o.device = "MOTU 896mk3 Hybrid"; //setea tarjeta de audio
o.outDevice.postln; //imprimir dispositivo de salida
s.boot; ///bootear servidos
)
// test rutine
///prueba de bocinas una por una
p = ProxySpace.push;
~test1 = { SinOsc.ar([1] * 100) * 0.1 };
~test1.play(1); //aqui número de bocina
~test1.stop


//Variables *******************************************************

(
q = q ? ();

// all possible sinths
q.allSintes = [\Suno, \Sdos, \Stres, \Scuatro, \Scinco, \Sseis, \Ssiete, \Socho, \Snueve];
q.allchannels = [\1, \2, \3, \4, \5, \6, \7, \8, ];


//SynthDef(s) *******************************************************

(
SynthDef.new(\uno,{
	arg freq=40, nharm=12, detune=0.2, gate=0, pan=0,
	amp=1, out=0;
	var sig, env;
	env = EnvGen.kr(Env.adsr(0.05,0.1,0.5,3),gate);
	sig = Blip.ar(
		freq *
		LFNoise1.kr(0.2!8).bipolar(detune.neg,detune).midiratio,nharm
	);
	sig = sig * LFNoise1.kr(0.5!8).exprange(0.1,1);
	sig = Splay.ar(sig); //lo hace stereo quitar para multicanal
	sig = Balance2.ar(sig[0], sig[1], pan);
	sig = sig * env * amp;
	Out.ar(out,sig);
}).add
)


SynthDef.new(\dos,{
	arg freq=400, sustain=0.5,out=0;
	var sig, amp, env;
	env = EnvGen.kr(Env.adsr(0.01,0.3,sustain,1),doneAction:2);
	amp = SinOsc.kr({ExpRand(0.2, 12)}!8));
	sig = SinOsc.ar({ExpRand(freq, 1)}!8));
	sig = sig * amp * env;
	Out.ar(out, sig * 0.01);
}).add
)


// OSC function *******************************************************

//tenemos 3 raspberrys que estan enviando datos independientes

x = OSCFunc( { | msg, time, addr, port |
    var pySintA, pyNoteA, pyTimeA, pyChannelA;

    pySintA = msg[1].asFunction;
	pyNoteA = msg[2].asFunction;
  pyTimeA = msg[3].asFunction;
	pyChannelA = msg [4].asFunction;
    ( "SintA is " + pySintA ).postln;
	("NoteA is"+ pyNoteA).portln;
  ("TimeA is" + pyTimeA).portln;
	( "ChannelA is " + pyChannelA ).postln;
	h.set( \SintA, pySint,
		\NoteA, pyNote,
    \TimeA, pyTime,
		\channelA, pyChannel );
}, '/raspi1' );
)

y = OSCFunc( { | msg, time, addr, port |
    var pySint, pyNote, pyTime, pyChannel;

    pySint = msg[1].asFunction;
	pyNote = msg[2].asFunction;
  pyTime = msg[3].asFunction;
	pyChannel = msg [4].asFunction;
    ( "Sint is " + pySint ).postln;
	("Note is"+ pyNote).portln;
  ("Time is" + pyTime).portln;
	( "Channel is " + pyChannel ).postln;
	h.set( \sint, pySint,
		\note, pyNote,
    \time, pyTime,
		\channel, pyChannel );
}, '/raspi2' );
)


// logica de seleccion *************************************************************
// selecionar que sinte y en que canal se toca de acuerdo a los datos osc

q.initPlaySints = {
	q.currPlaySints = ();
	q.sints.do { |name, i|
		var channel = q.allchannels.[\channel];
		var sints = q.allSintes[ \sint];
		//var subcat = if (subcats.notNil) { subcats.choose };
		q.currPlaySints.put(name, (channel: channel, sints: sints));
	};
	q.currPlaySints;
};


if (q.currPlaySints = 0) {
		Pe = Synth.new(\uno);
    pyTimeA.wait;
    e.free;
	};

if (q.currPlaySints = 1) {
    g = Synth.new(\dos);
    g.set
    g.free;
  };
