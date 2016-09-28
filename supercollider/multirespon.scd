(
f = OSCFunc( { | msg, time, addr, port |
	var pyFreq,pyNharm,pyDetune,pyOut;
	pyFreq = msg[1]; //valores originales del 0 al 5
	pyNharm = msg[2]; //valores originales del 1 al 30
	pyDetune = msg[3];//valores originales del 1 al 100 milisegundos
	pyOut = msg[4];//valores originales del 1 al 8
	( "/raspi1/freq is " + pyFreq ).postln;
	( "/raspi1/nharm " + pyNharm ).postln;
	( "/raspi1/detune " + pyDetune ).postln;
	//( "/raspi1/channel is " + pyOut).postln;
	e.set([\freq,pyFreq, \nharm,pyNharm, \detune,pyDetune],
		f.set([\freq,pyFreq, \nharm,pyNharm, \detune,pyDetune]),
		g.set ([\freq,pyFreq, \nharm,pyNharm, \detune,pyDetune]),
		 );
}, '/raspi1/' );
)