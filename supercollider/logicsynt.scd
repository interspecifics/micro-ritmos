
(
q = q ? ();

// all possible sinths
q.allSintes = [\Suno, \Sdos, \Stres, \Scuatro, \Scinco, \Sseis, \Ssiete, \Socho, \Snueve];
q.allchannels = [\1, \2, \3, \4, \5, \6, \7, \8, ];

x = OSCFunc( { | msg, time, addr, port |
    var pySint, pyNote, pyChannel;

    pySint = msg[1].asFunction;
	pyNote = msg[2].asFunction
	pyChannel = msg [3].asFunction;
    ( "Sint is " + pySint ).postln;
	("Note is"+ pyNote).portln;
	( "Channel is " + pyChannel ).postln;
	h.set( \sint, pySint,
		\note, pyNore,
		\channel, pyChannel );
}, '/raspi1' );
)


//initiate sints

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


(
SynthDef.new(\tone,{
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




