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

    // prueba de canales uno por uno
~test1 = { SinOsc.ar([1] * 100) * 0.1 };
~test1.play(1); //aqui número de bocina
~test1.stop

//////8 channel continum changing panning
(
~uno = {
	arg out;
 {
    PanAz.ar(
        out,                 // numChans
        ClipNoise.ar,     // in
        LFSaw.kr(LFNoise1.kr(0.3).unipolar),0.01,2,0.5
    );
	}
};
)


~uno.play;
~uno.free;


(
x = OSCFunc( { | msg, time, addr, port |
    var pyChannel;
	pyChannel = msg[1];
	( "channel is " + pyChannel ).postln;
	~uno.set( \out, pyChannel,
		 );
}, '/raspi2' );
)


////spreads an array of channels across a ring of channels.
(
x = { var src;
 src = SinOsc.ar( { |i| LFNoise2.kr( rrand(10, 20), 200, i * 100 + 400) } ! 10);
 SplayAz.ar(8, src, MouseY.kr(1, 0), 0.2, center: MouseX.kr(-1, 1));
}.scope;
)
x.free;


{SinOsc.ar( { |i| LFNoise2.kr( rrand(10, 20), 200, i * 100 + 400) } ).play};

////
{ PanAz.ar(8, Impulse.ar(Rand(1, 4), 0, 0.5), LFNoise1.kr(0.1)) }.play;

(
a = (
{ PanAz.ar(8, Impulse.ar(6, 0, 0.5) + WhiteNoise.ar(0.5), LFSaw.kr(LFNoise1.kr(0.3)),0.5,2,0.5);
	}.play;
);
)
a.free;









