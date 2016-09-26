s.boot;

(

SynthDef(\test_alive, {|freq=330,out_bus=0,gate=1,dur=2, amp=0.5|
   var sig = amp * SinOsc.ar(freq);
   sig = sig * EnvGen.kr( Env.perc(1/20,dur), gate, doneAction: 2 );

   Out.ar( 0, sig )

}).send(s);

x = Synth(\test_alive);
x.set(\dur,3);
NodeWatcher.register( x );


y = Synth(\test_alive);
y.set(\freq,443);
y.set(\dur,3);

NodeWatcher.register( y );

fork{
   inf.do{|i|

      if( x.isPlaying == false,{
         ("X is dead. Restart.").postln;
         x = Synth(\test_alive);
         x.set(\dur,3);
         NodeWatcher.register( x );
      });
      if( y.isPlaying == false,{
         ("Y is dead. Restart.").postln;
         y = Synth(\test_alive);
         y.set(\freq,443);
         y.set(\dur,7);
         NodeWatcher.register( y );
      });

      0.3.wait;
   }
};

)
