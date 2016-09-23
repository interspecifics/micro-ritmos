
(
q = q ? ();

// all possible sinths
q.allSintes = [\Suno, \Sdos, \Stres, \Scuatro, \Scinco, \Sseis, \Ssiete, \Socho, \Snueve];
q.allchannels = [\1, \2, \3, \4, \5, \6, \7, \8, ];

x = OSCFunc( { | msg, time, addr, port |
    var pySint, pyChannel;

    pySint = msg[1].asFunction;
	pyChannel = msg [2].asFunction;
    ( "Sint is " + pySint ).postln;
	( "Channel is " + pyChannel ).postln;
	h.set( \sint, pySint,
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





