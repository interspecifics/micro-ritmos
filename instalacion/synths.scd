~load_synths = {
	"cargar sonidos".postln;




	// ---------------------------------------------------------------
	SynthDef(\pi1_synth1,{
		arg freq1=200,freq2=300, gate=1, dur=0.1, amp=0.5,out=0;

		var env,sig;
		var pan;

		env = EnvGen.kr(Env.perc(1/20,dur), gate, doneAction: 2);
		sig = SinOsc.ar(BrownNoise.ar(freq1, freq2));
		sig = sig * amp * env;

		pan = (( out *2 )-1)/ 8;
		Out.ar( 0, PanAz.ar(8,
			sig,
			Lag.kr( pan, 3 )
		))

	}).send(s);
	// ---------------------------------------------------------------
	~buf2= Buffer.alloc(s, 512,1);
	~buf2.sine1(1/Array.fill(10,{|i| i+1}));
	SynthDef(\pi1_synth2, {|out= 0, gate= 1, amp= 0.25, dur= 0.1,
		modFreq=1, freq1=64, freq2=65, mul1=1, mul2=1|
		var env, mod, a, b, mixer;
		var pan;
		var sig;
		env = EnvGen.kr(Env.perc(1/20,dur), gate, doneAction: 2);
		mod = LFTri.ar(modFreq);
		a = Osc.ar (~buf2, freq1, mod, mul1);
		b = Osc.ar (~buf2, freq2, mod, mul2);
		mixer= Mix.new([a,b]);
		sig = mixer*(env*amp);


		pan = (( out *2 )-1)/ 8;
		Out.ar( 0, PanAz.ar(8,
			sig,
			Lag.kr( pan, 3 )
		))

	}).send(s);
	// ---------------------------------------------------------------
	SynthDef(\pi1_synth3, {
		|freq=440, dur=0.1, gate=1, amp=0.5,out=0|
		var env, sig;
		var pan;
		env = EnvGen.kr(Env.perc(1/20,dur), gate, doneAction: 2);
		sig = SinOsc.ar([1, 1.334840, 1.587401] * freq, 0, 0.2).sum;


		pan = (( out *2 )-1)/ 8;
		Out.ar( 0, PanAz.ar(8,
			sig,
			Lag.kr( pan, 3 )
		))

	}).send(s);
	// ---------------------------------------------------------------
	SynthDef(\pi1_synth4,{|out= 0, gate= 1, amp= 0.25, fund=200, pulseFreq=0.5, sus=100, dur=100|
		var env, sound,sound2, pulse, percEnv;
		var pan;
		var sig;
		env = EnvGen.ar(Env.asr(0.01, sus, 0.5), gate, doneAction:2);
		sound = Array.fill(10, {SinOsc.ar(fund + Rand(0,200), Rand(0.0,1.0), 10.reciprocal) * EnvGen.ar(Env.perc(0.1, 2+Rand(0.0,dur)))});
		sound= Mix(sound);
		sig = sound;

		pan = (( out *2 )-1)/ 8;
		Out.ar( 0, PanAz.ar(8,
			sig,
			Lag.kr( pan, 3 )
		))

	}).send(s);
	// ---------------------------------------------------------------
	SynthDef(\pi1_synth5, {|freq=330,out=0,gate=1,dur=0.1, amp=0.5|
		var pan;
		var sig;
		sig = amp * Blip.ar(freq) * EnvGen.kr( Env.perc(1/20,dur), gate, doneAction: 2 );

		pan = (( out *2 )-1)/ 8;
		Out.ar( 0, PanAz.ar(8,
			sig,
			Lag.kr( pan, 3 )
		))

	}).send(s);


	SynthDef(\pi1_synth6, {|freq=330,out=0,gate=1,dur=0.1, amp=0.5|
		var sig;
		var pan;
		sig = amp * FreeVerb.ar( Blip.ar(freq), 1, 1 ) * EnvGen.kr( Env.perc(1/20,dur), gate, doneAction: 2 );

		pan = (( out *2 )-1)/ 8;
		Out.ar( 0, PanAz.ar(8,
			sig,
			Lag.kr( pan, 3 )
		))

	}).send(s);
	// ---------------------------------------------------------------
	// pi2 synths
	// ---------------------------------------------------------------

	SynthDef(\pi2_synth1,{
		arg freq1=200,freq2=300, gate=1, dur=0.1, amp=0.5,out=0;
		var env,sig;
		var pan;
		env = EnvGen.kr(Env.perc(1/20,dur), gate, doneAction: 2);
		sig = SinOsc.ar(BrownNoise.ar(freq1, freq2));
		sig = sig * amp * env;


		pan = (( out *2 )-1)/ 8;
		Out.ar( 0, PanAz.ar(8,
			sig,
			Lag.kr( pan, 3 )
		))

	}).send(s);
	// ---------------------------------------------------------------
	~buf2= Buffer.alloc(s, 512,1);
	~buf2.sine1(1/Array.fill(10,{|i| i+1}));
	SynthDef(\pi2_synth2, {|out= 0, gate= 1, amp= 0.25, dur= 0.1,
		modFreq=1, freq1=64, freq2=65, mul1=1, mul2=1|
		var env, mod, a, b, mixer;
		var pan;
		var sig;
		env = EnvGen.kr(Env.perc(1/20,dur), gate, doneAction: 2);
		mod = LFTri.ar(modFreq);
		a = Osc.ar (~buf2, freq1, mod, mul1);
		b = Osc.ar (~buf2, freq2, mod, mul2);
		mixer= Mix.new([a,b]);
		sig = mixer * (env *amp);


		pan = (( out *2 )-1)/ 8;
		Out.ar( 0, PanAz.ar(8,
			sig,
			Lag.kr( pan, 3 )
		))


	}).send(s);
	// ---------------------------------------------------------------
	SynthDef(\pi2_synth3, {
		|freq=440, dur=0.1, gate=1, amp=0.5,out=0|
		var env, sig;

		var pan;
		env = EnvGen.kr(Env.perc(1/20,dur), gate, doneAction: 2);
		sig = SinOsc.ar([1, 1.334840, 1.587401] * freq, 0, 0.2).sum;
		sig = env * sig * amp;

		pan = (( out *2 )-1)/ 8;
		Out.ar( 0, PanAz.ar(8,
			sig,
			Lag.kr( pan, 3 )
		))

	}).send(s);
	// ---------------------------------------------------------------
	SynthDef(\pi2_synth4,{|out= 0, gate= 1, amp= 0.25, fund=200, pulseFreq=0.5, sus=100, dur=100|
		var env, sound,sound2, pulse, percEnv;
		var pan;
		var sig;

		env = EnvGen.ar(Env.asr(0.01, sus, 0.5), gate, doneAction:2);
		sound = Array.fill(10, {SinOsc.ar(fund + Rand(0,200), Rand(0.0,1.0), 10.reciprocal) * EnvGen.ar(Env.perc(0.1, 2+Rand(0.0,dur)))});
		sound= Mix(sound);

		sig= sound;

		pan = (( out *2 )-1)/ 8;
		Out.ar( 0, PanAz.ar(8,
			sig,
			Lag.kr( pan, 3 )
		))


	}).send(s);

	// ---------------------------------------------------------------
	SynthDef(\pi2_synth5, {|freq=330,out=0,gate=1,dur=0.1, amp=0.5|
		var sig = amp * Blip.ar(freq*2) * EnvGen.kr( Env.perc(1/20,dur), gate, doneAction: 2 );
		var pan;


		pan = (( out *2 )-1)/ 8;
		Out.ar( 0, PanAz.ar(8,
			sig,
			Lag.kr( pan, 3 )
		))


	}).send(s);

	SynthDef(\pi2_synth6, {|freq=330,out=0,gate=1,dur=0.1, amp=0.5|
		var sig = amp * FreeVerb.ar( Blip.ar(freq*2), 1, 1 ) * EnvGen.kr( Env.perc(1/20,dur), gate, doneAction: 2 );
		var pan;

		pan = (( out *2 )-1)/ 8;
		Out.ar( 0, PanAz.ar(8,
			sig,
			Lag.kr( pan, 3 )
		))

	}).send(s);
	// pi3 synths
	// ---------------------------------------------------------------
	SynthDef(\pi3_synth1,{
		arg freq1=200,freq2=300, gate=1, dur=0.1, amp=0.5,out=0;
		var env,sig;
		var pan;
		env = EnvGen.kr(Env.perc(1/20,dur), gate, doneAction: 2);
		sig = SinOsc.ar(BrownNoise.ar(freq1, freq2));
		sig = sig * amp * env;


		pan = (( out *2 )-1)/ 8;
		Out.ar( 0, PanAz.ar(8,
			sig,
			Lag.kr( pan, 3 )
		))

	}).send(s);
	// ---------------------------------------------------------------
	~buf2= Buffer.alloc(s, 512,1);
	~buf2.sine1(1/Array.fill(10,{|i| i+1}));
	SynthDef(\pi3_synth2, {|out= 0, gate= 1, amp= 0.25, dur= 0.1,
		modFreq=1, freq1=64, freq2=65, mul1=1, mul2=1|
		var env, mod, a, b, mixer;
		var pan, sig;
		env = EnvGen.kr(Env.perc(1/20,dur), gate, doneAction: 2);
		mod = LFTri.ar(modFreq);
		a = Osc.ar (~buf2, freq1, mod, mul1);
		b = Osc.ar (~buf2, freq2, mod, mul2);
		mixer= Mix.new([a,b]);
		sig = mixer * (env *amp);


		pan = (( out *2 )-1)/ 8;
		Out.ar( 0, PanAz.ar(8,
			sig,
			Lag.kr( pan, 3 )
		))

	}).send(s);
	// ---------------------------------------------------------------
	SynthDef(\pi3_synth3, {
		|freq=440, dur=0.1, gate=1, amp=0.5,out=0|
		var env, sig;
		var pan;
		env = EnvGen.kr(Env.perc(1/20,dur), gate, doneAction: 2);
		sig = SinOsc.ar([1, 1.334840, 1.587401] * freq, 0, 0.2).sum;
		sig = env * sig * amp;


		pan = (( out *2 )-1)/ 8;
		Out.ar( 0, PanAz.ar(8,
			sig,
			Lag.kr( pan, 3 )
		))

	}).send(s);
	// ---------------------------------------------------------------
	SynthDef(\pi3_synth4,{|out= 0, gate= 1, amp= 0.25, fund=200, pulseFreq=0.5, sus=100, dur=100|
		var env, sound,sound2, pulse, percEnv;
		var pan;
		var sig;
		env = EnvGen.ar(Env.asr(0.01, sus, 0.5), gate, doneAction:2);
		sound = Array.fill(10, {SinOsc.ar(fund + Rand(0,200), Rand(0.0,1.0), 10.reciprocal) * EnvGen.ar(Env.perc(0.1, 2+Rand(0.0,dur)))});
		sound= Mix(sound);
		sig = sound;


		pan = (( out *2 )-1)/ 8;
		Out.ar( 0, PanAz.ar(8,
			sig,
			Lag.kr( pan, 3 )
		))

	}).send(s);
	// ---------------------------------------------------------------
	SynthDef(\pi3_synth5, {|freq=330,out=0,gate=1,dur=0.1, amp=0.5|


		var sig = amp * Blip.ar(freq*3) * EnvGen.kr( Env.perc(1/20,dur), gate, doneAction: 2 );
		var pan;

		pan = (( out *2 )-1)/ 8;
		Out.ar( 0, PanAz.ar(8,
			sig,
			Lag.kr( pan, 3 )
		))

	}).send(s);
	SynthDef(\pi3_synth6, {|freq=330,out=0,gate=1,dur=0.1, amp=0.5|
		var sig = amp * FreeVerb.ar( Blip.ar(freq*3), 1, 1 ) * EnvGen.kr( Env.perc(1/20,dur), gate, doneAction: 2 );
		var pan;


		pan = (( out *2 )-1)/ 8;
		Out.ar( 0, PanAz.ar(8,
			sig,
			Lag.kr( pan, 3 )
		))


	}).send(s);






};