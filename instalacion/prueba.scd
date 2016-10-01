~pis = [1,2,3];

~num_pis = ~pis.size;

~num_pis.postln;

~num_outs = 2;
~num_synths = 6;


n = NetAddr("127.0.0.1", NetAddr.langPort); // local machine
m = NetAddr("127.0.0.1", NetAddr.langPort); // loopback


Tdef(\prueba, {
	inf.do{|i|
		var num_pi = ~pis[ i % ~num_pis ];
		var out_chan = i % ~num_outs;
		var synth_id = (i/3).floor % ~num_synths;
		m.sendMsg(
			"/raspi"++num_pi++'/',
			synth_id,                  // numero de sinte 0 - 5
			( ( i % 16 ) + 1 ) * 100,  // param1 -> freq, aumenta de 100 a 1600 en 16 pasos
			( ( i % 15 ) + 1 ) / 4,    // param2 -> dur, controla la duracion de la nota
			out_chan
		);
		0.001.wait;
	}
});

~start_test = {
	Tdef(\prueba).play();
};


~stop_test = {
	Tdef(\prueba).stop();
};