

// Configuration *******************************************************
//gui button iniciate signal
((
var value = 0.5;
w = Window.new.front;

// (1) create a UserView
v = UserView(w,Rect(50,50,200,20));
// (2) define a drawing function using Pen
v.drawFunc = {
	  // Draw the frame
   // Pen.strokeColor = Color.black;
    //Pen.addRect(Rect(0,10, v.bounds.width+100,v.bounds.height+100));
    //Pen.stroke;

    // Draw the button
    b = Button(w, Rect(100,100,200,60)).states_([
	["Iniciar Programa",Color.white(0.1),Color.black(0.0)],

]);
};

// (3) set the default action
v.action = {value.postln; v.refresh};

StaticText(w,Rect(100,200,350,50)).string_("
- 1 Presione boton encender
- 2 espere que inici super collider
- 3 encienda las luces 1 al 3
- 4 encienda raspberrys
- 5 encienda bocinas ");

)

///////// INICIA SERVER Y MOTU ////////

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
// tendriamos 6 tipos diferentes
// cada uno tiene sus argumentos variables ligados al osc

// ------------UNO-------------------------------//
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

// ------------DOS-------------------------------//


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

// ------------Tres-------------------------------//
 {WhiteNoise.ar(0.1)!2}.play; //falta hacerlo SynthDef
//
///////////////////////////////////////////////////////////////////////


// OSC function *******************************************************
//recibimos desde 3 rutas de raspberrys que estan enviando datos independientes

// ================UNO=================================//
x = OSCFunc( { | msg, time, addr, port |
	var pyFreq,pyNharm,pyDetune,pyOut;
	pyFreq = msg[1]; //valores originales del 0 al 5
	pyNharm = msg[2]; //valores originales del 1 al 30
	pyDetune = msg[3];//valores originales del 1 al 100 milisegundos
	pyOut = msg[4];//valores originales del 1 al 8
	( "freq is " + pyFreq ).postln;
	( "nharm " + pyNharm ).postln;
	( "detune " + pyDetune ).postln;
	( "channel is " + pyOut).postln;
	e.set(\freq,pyFreq + 1 * 50, \nharm,pyNharm * 2, \detune,pyDetune /2.5, \out, pyOut,
		 );
}, '/raspi1/' );


// ================DOS=================================//

f = OSCFunc( { | msg, time, addr, port |
    var pyFreq,pyNharm,pyDetune,pyOut;

  pyFreq  = msg[1].asFunction; // 0 - 6 int
	pyNharm = msg[2].asFunction; // 0 - 30  int
  pyDetune = msg[3].asFunction; // 0 - 400  int
	pyOut = msg [4].asFunction; // 0 - 8 int
  ( "freq is " + pyFreq ).postln;
  ( "nharm " + pyNharm ).postln;
  ( "detune " + pyDetune ).postln;
  ( "channel is " + pyOut).postln;
	h.set( \SintA, pyFreq, \NoteA, pyNharm, \TimeA, pyDetune, \channelA, pyOut ); // para la salida logica
  g.set(\freq,pyFreq, \nharm,pyNharm, \detune,pyDetune * 2, \out, pyOut.asFlot * 3, // para las caracteriticas del sinte
}, '/raspi2' );

// ================TRES=================================//

y = OSCFunc( { | msg, time, addr, port |
    var pySintB, pyNoteB, pyTimeB, pyChannelB;

    pySint = msg[1].asFunction; // 0 -6 int
	pyNote = msg[2].asFunction; // 0 - 30 int
  pyTime = msg[3].asFunction; // 0 - 400 int
	pyChannel = msg [4].asFunction; // 0 - 8 int
    ( "Sint is " + pySint ).postln;
	("Note is"+ pyNote).portln;
  ("Time is" + pyTime).portln;
	( "Channel is " + pyChannel ).postln;
	h.set( \sint, pySint,
		\note, pyNote,
    \time, pyTime,
		\channel, pyChannel );
}, '/raspi3' );
)


// logica de seleccion *************************************************************
// selecionar que sinte y en que canal se toca de acuerdo a los datos osc
// 6 sintes
// 8 canales

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
		e = Synth.new(\uno);
    pyTimeA.wait;
    e.free;
	};

if (q.currPlaySints = 1) {
    g = Synth.new(\dos);
    g.set
    g.free;
  };

  // sobre la espacialización.
  // calcular el bus en el que se encuentra el sinte y moverlo logaritmico hasta la siguiente
  // posicion en el array de buses.

 // [1 -8 se desplaza por 7 canales hasta el 8 ]
 // [2- 5 se desplaza por 2 canales hasta el 5] etc

[ 1 > 2] [1<2]
[ 1 > 3] [1<3]
[ 1 > 4  [1<4]
[ 1 > 5] [1<5]
