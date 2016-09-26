s.boot;


(

~pis = [1,2,3];
~num_pis = ~pis.size;
~num_pis.postln;
~num_outs = 8;
~num_synths = 6;


n = NetAddr("127.0.0.1", NetAddr.langPort); // local machine
m = NetAddr("127.0.0.1", NetAddr.langPort); // loopback



// primero vamos a declarar 6 synths para cada una de las pi's ( 3 pis * 6 = 18 )

// pi1 synths

// ---------------------------------------------------------------

SynthDef(\pi1_synth1,{
	arg freq1=200,freq2=300, gate=1, dur=0.1, amp=0.5,out=0;
	var env,sig;
	env = EnvGen.kr(Env.perc(1/20,dur), gate, doneAction: 2);
	sig =  SinOsc.ar(BrownNoise.ar(freq1, freq2));
	sig = sig * amp * env;
	Out.ar(out,sig);
}).send(s);

// ---------------------------------------------------------------

~buf2= Buffer.alloc(s, 512,1);
~buf2.sine1(1/Array.fill(10,{|i| i+1}));

SynthDef(\pi1_synth2, {|out= 0, gate= 1, amp= 0.25, dur= 0.1,
modFreq=1, freq1=64, freq2=65, mul1=1, mul2=1|
	var env, mod, a, b, mixer;
	env = EnvGen.kr(Env.perc(1/20,dur), gate, doneAction: 2);
	mod = LFTri.ar(modFreq);
	a = Osc.ar (~buf2, freq1,  mod, mul1);
	b = Osc.ar (~buf2, freq2, mod,  mul2);
	mixer= Mix.new([a,b]);
	Out.ar(out, mixer * (env *amp));
}).send(s);

// ---------------------------------------------------------------


SynthDef(\pi1_synth3, {
	|freq=440, dur=0.1, gate=1, amp=0.5,out=0|
	var env, sig;
	env = EnvGen.kr(Env.perc(1/20,dur), gate, doneAction: 2);
	sig = SinOsc.ar([1, 1.334840, 1.587401] * freq, 0, 0.2).sum;
	Out.ar(out, env * sig * amp);
}).send(s);


// ---------------------------------------------------------------

SynthDef(\pi1_synth4,{|out= 0, gate= 1, amp= 0.25, fund=200, pulseFreq=0.5, sus=100, dur=100|
	var env, sound,sound2, pulse, percEnv;
	env = EnvGen.ar(Env.asr(0.01, sus, 0.5), gate, doneAction:2);
	sound = Array.fill(10, {SinOsc.ar(fund + Rand(0,200), Rand(0.0,1.0), 10.reciprocal) * EnvGen.ar(Env.perc(0.1, 2+Rand(0.0,dur)))});
	sound= Mix(sound);
Out.ar(out, sound )
}).send(s);

// ---------------------------------------------------------------


SynthDef(\pi1_synth5, {|freq=330,out=0,gate=1,dur=0.1, amp=0.5|
   Out.ar( out, amp * Blip.ar(freq) * EnvGen.kr( Env.perc(1/20,dur), gate, doneAction: 2 ) )
}).send(s);
SynthDef(\pi1_synth6, {|freq=330,out=0,gate=1,dur=0.1, amp=0.5|
   Out.ar( out, amp * FreeVerb.ar( Blip.ar(freq), 1, 1 ) * EnvGen.kr( Env.perc(1/20,dur), gate, doneAction: 2 ) )
}).send(s);

// ---------------------------------------------------------------



// pi2 synths


// ---------------------------------------------------------------

SynthDef(\pi2_synth1,{
	arg freq1=200,freq2=300, gate=1, dur=0.1, amp=0.5,out=0;
	var env,sig;
	env = EnvGen.kr(Env.perc(1/20,dur), gate, doneAction: 2);
	sig =  SinOsc.ar(BrownNoise.ar(freq1, freq2));
	sig = sig * amp * env;
	Out.ar(out,sig);
}).send(s);

// ---------------------------------------------------------------

~buf2= Buffer.alloc(s, 512,1);
~buf2.sine1(1/Array.fill(10,{|i| i+1}));

SynthDef(\pi2_synth2, {|out= 0, gate= 1, amp= 0.25, dur= 0.1,
modFreq=1, freq1=64, freq2=65, mul1=1, mul2=1|
	var env, mod, a, b, mixer;
	env = EnvGen.kr(Env.perc(1/20,dur), gate, doneAction: 2);
	mod = LFTri.ar(modFreq);
	a = Osc.ar (~buf2, freq1,  mod, mul1);
	b = Osc.ar (~buf2, freq2, mod,  mul2);
	mixer= Mix.new([a,b]);
	Out.ar(out, mixer * (env *amp));
}).send(s);

// ---------------------------------------------------------------


SynthDef(\pi2_synth3, {
	|freq=440, dur=0.1, gate=1, amp=0.5,out=0|
	var env, sig;
	env = EnvGen.kr(Env.perc(1/20,dur), gate, doneAction: 2);
	sig = SinOsc.ar([1, 1.334840, 1.587401] * freq, 0, 0.2).sum;
	Out.ar(out, env * sig * amp);
}).send(s);


// ---------------------------------------------------------------

SynthDef(\pi2_synth4,{|out= 0, gate= 1, amp= 0.25, fund=200, pulseFreq=0.5, sus=100, dur=100|
	var env, sound,sound2, pulse, percEnv;
	env = EnvGen.ar(Env.asr(0.01, sus, 0.5), gate, doneAction:2);
	sound = Array.fill(10, {SinOsc.ar(fund + Rand(0,200), Rand(0.0,1.0), 10.reciprocal) * EnvGen.ar(Env.perc(0.1, 2+Rand(0.0,dur)))});
	sound= Mix(sound);
Out.ar(out, sound )
}).send(s);

// ---------------------------------------------------------------

SynthDef(\pi2_synth5, {|freq=330,out=0,gate=1,dur=0.1, amp=0.5|
   Out.ar( out, amp * Blip.ar(freq*2) * EnvGen.kr( Env.perc(1/20,dur), gate, doneAction: 2 ) )
}).send(s);
SynthDef(\pi2_synth6, {|freq=330,out=0,gate=1,dur=0.1, amp=0.5|
   Out.ar( out, amp * FreeVerb.ar( Blip.ar(freq*2), 1, 1 ) * EnvGen.kr( Env.perc(1/20,dur), gate, doneAction: 2 ) )
}).send(s);



// pi3 synths


// ---------------------------------------------------------------

SynthDef(\pi3_synth1,{
	arg freq1=200,freq2=300, gate=1, dur=0.1, amp=0.5,out=0;
	var env,sig;
	env = EnvGen.kr(Env.perc(1/20,dur), gate, doneAction: 2);
	sig =  SinOsc.ar(BrownNoise.ar(freq1, freq2));
	sig = sig * amp * env;
	Out.ar(out,sig);
}).send(s);

// ---------------------------------------------------------------

~buf2= Buffer.alloc(s, 512,1);
~buf2.sine1(1/Array.fill(10,{|i| i+1}));

SynthDef(\pi3_synth2, {|out= 0, gate= 1, amp= 0.25, dur= 0.1,
modFreq=1, freq1=64, freq2=65, mul1=1, mul2=1|
	var env, mod, a, b, mixer;
	env = EnvGen.kr(Env.perc(1/20,dur), gate, doneAction: 2);
	mod = LFTri.ar(modFreq);
	a = Osc.ar (~buf2, freq1,  mod, mul1);
	b = Osc.ar (~buf2, freq2, mod,  mul2);
	mixer= Mix.new([a,b]);
	Out.ar(out, mixer * (env *amp));
}).send(s);

// ---------------------------------------------------------------


SynthDef(\pi3_synth3, {
	|freq=440, dur=0.1, gate=1, amp=0.5,out=0|
	var env, sig;
	env = EnvGen.kr(Env.perc(1/20,dur), gate, doneAction: 2);
	sig = SinOsc.ar([1, 1.334840, 1.587401] * freq, 0, 0.2).sum;
	Out.ar(out, env * sig * amp);
}).send(s);


// ---------------------------------------------------------------

SynthDef(\pi3_synth4,{|out= 0, gate= 1, amp= 0.25, fund=200, pulseFreq=0.5, sus=100, dur=100|
	var env, sound,sound2, pulse, percEnv;
	env = EnvGen.ar(Env.asr(0.01, sus, 0.5), gate, doneAction:2);
	sound = Array.fill(10, {SinOsc.ar(fund + Rand(0,200), Rand(0.0,1.0), 10.reciprocal) * EnvGen.ar(Env.perc(0.1, 2+Rand(0.0,dur)))});
	sound= Mix(sound);
Out.ar(out, sound )
}).send(s);

// ---------------------------------------------------------------

SynthDef(\pi3_synth5, {|freq=330,out=0,gate=1,dur=0.1, amp=0.5|
   Out.ar( out, amp * Blip.ar(freq*3) * EnvGen.kr( Env.perc(1/20,dur), gate, doneAction: 2 ) )
}).send(s);
SynthDef(\pi3_synth6, {|freq=330,out=0,gate=1,dur=0.1, amp=0.5|
   Out.ar( out, amp * FreeVerb.ar( Blip.ar(freq*3), 1, 1 ) * EnvGen.kr( Env.perc(1/20,dur), gate, doneAction: 2 ) )
}).send(s);





// almacenar los nombres de los synths en los siguientes arrays:

~pi1_synth_names = [
   \pi1_synth1,
   \pi1_synth2,
   \pi1_synth3,
   \pi1_synth4,
   \pi1_synth5,
   \pi1_synth6
];
~pi2_synth_names = [
   \pi2_synth1,
   \pi2_synth2,
   \pi2_synth3,
   \pi2_synth4,
   \pi2_synth5,
   \pi2_synth6
];
~pi3_synth_names = [
   \pi3_synth1,
   \pi3_synth2,
   \pi3_synth3,
   \pi3_synth4,
   \pi3_synth5,
   \pi3_synth6
];


~pi_synth_names = Dictionary.new();
~synths = Dictionary.new();

~pi_synth_names[1] = ~pi1_synth_names;
~pi_synth_names[2] = ~pi2_synth_names;
~pi_synth_names[3] = ~pi3_synth_names;

~synths[1] = Dictionary.new();
~synths[2] = Dictionary.new();
~synths[3] = Dictionary.new();

// crear responders para cada una de las pis:


// PI 1:

OSCFunc.newMatching({ | msg, time, addr, port |

   var pi_id = 1;

   var synth_id, param1, param2, out_channel;

   synth_id    = msg[1].asInteger;
   param1      = msg[2].asInteger;
   param2      = msg[3].asFloat;
   out_channel = msg[4].asInteger;


   ~this_pi_synths = ~pi_synth_names[pi_id];

   if( synth_id != nil, {
      ~synth_name = ~pi_synth_names[ pi_id ][ synth_id ];

      ( "OSCFunc " ++ pi_id ++ " plays: " ++ ~synth_name ).postln;
      "".postln;

      ~synths[ 1 ][ \pi1_synth1 ] = Synth(
         \pi1_synth1,
         [
			freq1: param1.rrand(100,300),
			freq2: param1.rrand(200,400),
            dur: param2,
            out: out_channel % ~num_outs
         ]);


		~synths[ 1 ][ \pi1_synth2 ] = Synth(
         \pi1_synth2,
         [
			freq1: param1.rrand(60,80),
			freq2: param1.rrand(60,80),
            dur: param2,
            out: out_channel % ~num_outs
         ]);

			~synths[ 1 ][ \pi1_synth3 ] = Synth(
         \pi1_synth3,
         [
			freq: param1.rrand(45,80).midicps,
            dur: param2,
            out: out_channel % ~num_outs
         ]);


		~synths[ 1 ][ \pi1_synth4 ] = Synth(
         \pi1_synth4,
         [
            freq: param1,
			dur: param2,
            out: out_channel % ~num_outs
         ]);

   }, {});

}, '/raspi1/' );



// PI 2:

OSCFunc.newMatching({ | msg, time, addr, port |

   var pi_id = 2;

   var synth_id, param1, param2, out_channel;

   synth_id    = msg[1].asInteger;
   param1      = msg[2].asInteger;
   param2      = msg[3].asFloat;
   out_channel = msg[4].asInteger;


   ~this_pi_synths = ~pi_synth_names[pi_id];

   if( synth_id != nil, {
      ~synth_name = ~pi_synth_names[ pi_id ][ synth_id ];

      ( "OSCFunc " ++ pi_id ++ " plays: " ++ ~synth_name ).postln;
      "".postln;

     ~synths[ 2 ][ \pi2_synth1 ] = Synth(
         \pi2_synth1,
         [
				freq1: param1.rrand(100,300),
			freq2: param1.rrand(200,400),
            dur: param2,
            out: out_channel % ~num_outs
         ]);


		~synths[ 2 ][ \pi2_synth2 ] = Synth(
         \pi2_synth2,
         [
			freq1: param1.rrand(60,80),
			freq2: param1.rrand(60,80),
            dur: param2,
            out: out_channel % ~num_outs
         ]);

			~synths[ 2 ][ \pi2_synth3 ] = Synth(
         \pi2_synth3,
         [
			freq: param1.rrand(45,80).midicps,
            dur: param2,
            out: out_channel % ~num_outs
         ]);


		~synths[ 2 ][ \pi2_synth4 ] = Synth(
         \pi2_synth4,
         [
            freq: param1,
			dur: param2,
            out: out_channel % ~num_outs
         ]);
   }, {});

}, '/raspi2/' );



// PI 3:

OSCFunc.newMatching({ | msg, time, addr, port |

   var pi_id = 3;

   var synth_id, param1, param2, out_channel;

   synth_id    = msg[1].asInteger;
   param1      = msg[2].asInteger;
   param2      = msg[3].asFloat;
   out_channel = msg[4].asInteger;


   ~this_pi_synths = ~pi_synth_names[pi_id];

   if( synth_id != nil, {
      ~synth_name = ~pi_synth_names[ pi_id ][ synth_id ];

      ( "OSCFunc " ++ pi_id ++ " plays: " ++ ~synth_name ).postln;
      "".postln;


		~synths[ 3 ][ \pi3_synth1 ] = Synth(
         \pi3_synth1,
         [
			freq1: param1.rrand(100,300),
			freq2: param1.rrand(200,400),
            dur: param2,
            out: out_channel % ~num_outs
         ]);


		~synths[ 3 ][ \pi3_synth2 ] = Synth(
         \pi3_synth2,
         [
			freq1: param1.rrand(60,80),
			freq2: param1.rrand(60,80),
            dur: param2,
            out: out_channel % ~num_outs
         ]);

			~synths[ 3 ][ \pi3_synth3 ] = Synth(
         \pi3_synth3,
         [
			freq: param1.rrand(45,80).midicps,
            dur: param2,
            out: out_channel % ~num_outs
         ]);


		~synths[ 3 ][ \pi3_synth4 ] = Synth(
         \pi3_synth4,
         [
            freq: param1,
			dur: param2,
            out: out_channel % ~num_outs
         ]);


   }, {});

}, '/raspi3/' );





fork {
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
      2.wait;
   }
}



)
