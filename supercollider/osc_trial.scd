thisProcess.openPorts
NetAddr.localAddr
OSCFunc.trace(true);
OSCFunc.trace(false); // Turn posting off


(
SynthDef( \sin, { | amp = 0.01, freq = 333, trig = 1 |
    var env, sig;
    env = EnvGen.kr( Env.asr( 0.001, 0.9, 0.001 ), trig, doneAction: 0 );
    sig = LFTri.ar( [ freq, freq * 0.999 ], 0.0, amp ) * env;
    Out.ar( [ 0 ], sig * 0.6 );
}).add;

h = Synth( \sin, [ \amp, 0.4 ] );

x = OSCFunc( { | msg, time, addr, port |
    var pyFreq, pyAmp;

    pyFreq = msg[1].asFloat;
	pyAmp = msg [2].asFloat;
    ( "freq is " + pyFreq ).postln;
	( "amp is " + pyAmp ).postln;
	h.set( \freq, pyFreq,
		\amp, pyAmp );
}, '/direccion' );
)

h.free;

{Env.asr( 0.001, 0.9, 0.001)}.plot;


a = EnvGen.kr( Env.asr( 0.001, 0.9, 0.001 ));
a.test.plot;


(
SynthDef(\3valores, {
	|pitch = 80, sustain = 1, out = 0|
	var = env, sig;
	env = EnvGen.kr(Env.adsr(0.01,0.3,sustain, 1),1,doneAction:2);
	sig = SinOsc.ar({ExpRand(50,1200)})!8;


