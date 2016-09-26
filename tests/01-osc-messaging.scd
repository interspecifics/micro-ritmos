// testear estructura de mensaje:

n = NetAddr("127.0.0.1", NetAddr.langPort);

OSCFunc.newMatching( { | msg, time, addr, port |

   msg.postln;

   msg.collect{|part,i|
      ( "arg " ++ i ++ " is: " ++ part ).postln;
   }

}, '/testOSC/' );



m = NetAddr("127.0.0.1", NetAddr.langPort); // loopback

m.sendMsg("/testOSC/", "1", "0", "0", "1");
