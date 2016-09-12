{ SinOsc.ar(440, 0, 0.1)!8 }.play;

{LFSaw.ar(440,0,0.1)!2}.play;

{LFTri.ar(440, 0, 0.1)!2}.play;

{LFCub.ar(440, 0, 0.1)!2}.play;

{LFPar.ar(440, 0, 0.1)!2}.play;
s.plot;



{WhiteNoise.ar(0.1)!2}.play;

{BrownNoise.ar(0.1)!2}.play;

{PinkNoise.ar(0.1)!2}.play;

{ClipNoise.ar(0.1)!2}.play;



{Crackle.ar(1, 0.5)!2}.play


(
{ LatoocarfianN.ar(
    SampleRate.ir/4,
    LFNoise2.kr(2,1.5,1.5),
    LFNoise2.kr(2,1.5,1.5),
    LFNoise2.kr(2,0.5,1.5),
    LFNoise2.kr(2,0.5,1.5)
) * 0.2!2 }.play(s);
)


{ Logistic.ar(MouseX.kr(3, 3.99), MouseY.kr(10, 10000, 'exponential'), 0.25, 0.5) }.play


{Dust.ar(100, 0.5)!2}.play      // 10 - 10000

{LFNoise0.ar(220, 0.1)!2}.play;  // 10 - 2000
LFDNoise0
LFDNoise1
LFDNoise3
LFNoise1
LFNoise2

(
{ LFCub.ar(
        LFDNoise3.ar(4, 400, 450),
        0, 0.2
    )
}.play;
)


(
    // select all the code and run it
    // use mouse to strum strings
{
	var pitch, mousex, out;
	pitch = [ 52, 59, 66, 67, 71, 81 ];
	mousex = MouseX.kr;
	out = Mix.arFill(pitch.size, { arg i;
		var pos, trigger1, trigger2, pluck1, pluck2, period, string1, string2,
		delay, mix;

		pos = 0.25 + (i * 0.1);
		period = pitch.at(i).midicps.reciprocal;

		trigger1 = HPZ1.kr(mousex > pos).abs;
		pluck1 = PinkNoise.ar(Decay.kr(trigger1, 0.05));
		string1 = CombL.ar(pluck1, period, period, 4);

		trigger2 = HPZ1.kr(mousex > (pos + 0.015)).abs;
		pluck2 = PinkNoise.ar(Decay.kr(trigger2, 0.05));
		string2 = CombL.ar(pluck2, period/2, period/2, 4);

		mix = Mix([string1, string2]);
		delay = CombN.ar(mix, 0.2, 0.2, 2);
		mix = Mix([mix, delay * 0.2]);

		Pan2.ar(FreeVerb.ar(delay, 0.5, 0.9, 0.4), i * 0.2 - 0.5);
	});
	LPF.ar(out, 12000);

	LeakDC.ar(out);


}.play;
)


////
s.meter;
s.makeWindow;
s.scope;
FreqScope.new;



(
SynthDef(\tri, {|freq=440, mul=0.1, out=0|
    Out.ar(out,
        LFTri.ar(freq, 0, mul!2);
    );
}).add;
)

~tri = Synth(\tri, [\freq, 220, \mul, 0.05]);

(
50.do {
    Synth(\tri, [\freq, rrand(100, 5000), \mul, 0.01]);
}
)

s.killAll;
s.quit;



