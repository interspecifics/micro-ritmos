s.boot;

(
~num_outs = 8;

n = NetAddr("127.0.0.1", NetAddr.langPort); // local machine
m = NetAddr("127.0.0.1", NetAddr.langPort); // loopback

SynthDef(\spawn_test, {|freq=330,out=0,gate=1|
   Out.ar( out, 1/2 * SinOsc.ar(freq) * EnvGen.kr( Env.perc, gate, doneAction: 2 ) )
}).send(s);

// probar sinte:
x=Synth(\spawn_test);

~synths = Dictionary.new();


OSCFunc.newMatching({ | msg, time, addr, port |

   var synth_id, param1, param2, out_channel;
   msg.postln;
   synth_id    = msg[1].asInteger;
   param1      = msg[2].asInteger;
   param2      = msg[3].asInteger;
   out_channel = msg[4].asInteger;

   if( synth_id != nil, {
      ~synths[ synth_id ] = Synth(\spawn_test,[freq: param1, out: out_channel % ~num_outs ]);
   }, {

   });

}, '/createSynth' );

fork {
   inf.do{|i|
      var outchan = i % 8;
      var synth_id = i % 6;
      m.sendMsg("/createSynth", synth_id, (synth_id+1)*100, (synth_id+1)*100, outchan );
      1.wait;
   }
}

)
