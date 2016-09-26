s.boot;

(
~num_outs = 8;
~num_synths = 6;


n = NetAddr("127.0.0.1", NetAddr.langPort); // local machine
m = NetAddr("127.0.0.1", NetAddr.langPort); // loopback

SynthDef(\synth1, {|freq=330,out=0,gate=1,amp=0.5|
   Out.ar( out, amp * SinOsc.ar(freq) * EnvGen.kr( Env.perc, gate, doneAction: 2 ) )
}).send(s);
SynthDef(\synth2, {|freq=330,out=0,gate=1,amp=0.5|
   Out.ar( out, amp * LFPulse.ar(freq) * EnvGen.kr( Env.perc, gate, doneAction: 2 ) )
}).send(s);
SynthDef(\synth3, {|freq=330,out=0,gate=1,amp=0.5|
   Out.ar( out, amp * LFTri.ar(freq) * EnvGen.kr( Env.perc, gate, doneAction: 2 ) )
}).send(s);
SynthDef(\synth4, {|freq=330,out=0,gate=1,amp=0.5|
   Out.ar( out, amp * Saw.ar(freq) * EnvGen.kr( Env.perc, gate, doneAction: 2 ) )
}).send(s);
SynthDef(\synth5, {|freq=330,out=0,gate=1,amp=0.5|
   Out.ar( out, amp * Blip.ar(freq) * EnvGen.kr( Env.perc, gate, doneAction: 2 ) )
}).send(s);
SynthDef(\synth6, {|freq=330,out=0,gate=1,amp=0.5|
   Out.ar( out, amp * FreeVerb.ar( Blip.ar(freq), 1, 1 ) * EnvGen.kr( Env.perc, gate, doneAction: 2 ) )
}).send(s);

// probar sinte:
x=Synth(\spawn_test);

~synths = Dictionary.new();
~synth_names = [
   \synth1,
   \synth2,
   \synth3,
   \synth4,
   \synth5,
   \synth6
];


OSCFunc.newMatching({ | msg, time, addr, port |

   var synth_id, param1, param2, out_channel;

   synth_id    = msg[1].asInteger;
   param1      = msg[2].asInteger;
   param2      = msg[3].asFloat;
   out_channel = msg[4].asInteger;

   ( "synth_id: "    ++ synth_id    ).postln;
   ( "param1: "      ++ param1      ).postln;
   ( "param2: "      ++ param2      ).postln;
   ( "out_channel: " ++ out_channel ).postln;

   if( synth_id != nil, {

      ( "synth_name: "    ++ ~synth_names[ synth_id ] ).postln;

      ~synths[ synth_id ] = Synth(
         ~synth_names[ synth_id ],
         [
            freq: param1,
            amp: param2,
            out: out_channel % ~num_outs
         ]);
   }, {

   });

}, '/raspi1 );

fork {
   inf.do{|i|
      var outchan = out_channel;
      var synth_id = synth_id;
      m.sendMsg(
         "/createSynth",
         synth_id,                  // numero de sinte 0 - 5
         ( ( i % 16 ) + 1 ) * 100,  // param1 -> freq, aumenta de 100 a 1600 en 16 pasos
         ( ( i % 15 ) + 1 ) / 30,     // param1 -> amp, aumenta amplitud de 0 a 100% en 15 pasos
         outchan
      );
      2.wait;
   }
}

)