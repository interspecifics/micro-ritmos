s.boot;
(

SynthDef(\test_move, {|freq=330,out=0,gate=1,dur=15, amp=0.5|
   var sig = amp * SinOsc.ar(freq);
   //sig = sig * EnvGen.kr( Env.perc(1/20,dur), gate, doneAction: 2 );

   var pan = (( out *2 )-1)/ 8;
   Out.ar( 0, PanAz.ar(8,
      sig,
      Lag.kr( pan, 3 )
   ))

}).send(s);


x = Synth(\test_move);

x.set(\out, 0 );
x.set(\out, 1 );
x.set(\out, 2 );
x.set(\out, 3 );
x.set(\out, 4 );
x.set(\out, 5 );
x.set(\out, 6 );
x.set(\out, 7 );

)
