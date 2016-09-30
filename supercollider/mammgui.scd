(
~servidor ={
o = Server.local.options; ////variable para cambios en el servidor
o.numOutputBusChannels = 8; //setea 8 canales 8 de salida ANTES DE BOOTEAR!!
o.numOutputBusChannels.postln;/// imprime canales de salida habilitados
o.device = "MOTU 896mk3 Hybrid"; //setea tarjeta de audio
o.outDevice.postln; //imprimir dispositivo de salida
s.boot; ///bootear servidos
};

~sintesplay = {
e = Synth.new(\uno);
a=Synth(\noise1, [\Freq1,rrand(100,300),\freq2,rrand(200,400)]);
g=Synth(\panaz2);
x = Synth.new(\pulseTest;);
g = Synth(\drone1);
};

)

(
~respon1 = OSCFunc( { | msg, time, addr, port |
	var pyFreq,pyNharm,pyDetune,pyOut;
	pyFreq = msg[1]+1*30;
	pyNharm = msg[2];
	pyDetune = msg[3]/2.5;
	pyOut = msg[4];
	( "/raspi1/freq is " + pyFreq ).postln;
	( "/raspi1/nharm " + pyNharm ).postln;
	( "/raspi1/detune " + pyDetune ).postln;
		e.set([\freq,pyFreq, \nharm,pyNharm, \detune,pyDetune}),
		 );
}, '/raspi1/' );
};
)

d= OSCFunc( { | msg, time, addr, port |
	var pyFreq,pyNharm,pyDetune,pyOut;
	pyFreq = msg[1]+1*30; //valores originales del 0 al 5
	pyNharm = msg[2]; //valores originales del 1 al 30
	pyDetune = msg[3]/2.5;//valores originales del 1 al 100 milisegundos
	pyOut = msg[4];//valores originales del 1 al 8
	( "/raspi1/freq is " + pyFreq ).postln;
	( "/raspi1/nharm " + pyNharm ).postln;
	( "/raspi1/detune " + pyDetune ).postln;
	//( "/raspi1/channel is " + pyOut).postln;
	e.set(\freq,pyFreq, \nharm,pyNharm, \detune,pyDetune,
		 );
}, '/raspi1/' );

h = OSCFunc( { | msg, time, addr, port |
	var pyNoise,pyWidth;
	pyNoise = msg[1]+1.midiratio; //valores originales del 0 al 5
	//pyFreq = msg[2]/15; //valores originales del 1 al 30
	//pyDetune = msg[3]/2.5;//valores originales del 1 al 100 milisegundos
	pyWidth = msg[4]+1;//valores originales del 1 al 8
	( "/raspi2/noise is " + pyNoise ).postln;
	( "/raspi2/width is " + pyWidth).postln;
	//( "detune " + pyDetune ).postln;
	//( "channel is " + pyOut).postln;
	g.set(\noise,pyNoise,\width,pyWidth);
}, '/raspi2/' );

	var pyPart,pyWidth,pyFund,piAmphz;
	pyPart = msg[1]+1*2; //valores originales del 0 al 5
	piAmphz = msg[1].rrand(1,7);
	pyFund = msg[2].rrand(30,50); //valores originales del 1 al 30
	//piAmphz = msg[3]/2.5;//valores originales del 1 al 100 milisegundos
	pyWidth = msg[4]/2.asFloat.rrand(0.1,1);//valores originales del 1 al 8
	( "/raspi2/partial is " + pyPart ).postln;
	( "/raspi2/hz is " + piAmphz ).postln;
	( "/raspi2/fundamental is " + pyFund ).postln;
	( "/raspi2/width is " + pyWidth).postln;
	x.set(\maxPartial,pyPart,\ampHz,piAmphz,\fund,pyFund,\width,pyWidth);
}, '/raspi2/' );

i = OSCFunc( { | msg, time, addr, port |
	var pymodFreq,pyFreq1,pyFreq2;
	pymodFreq = msg[1]; //valores originales del 0 al 5
	pyFreq1 = msg[2]*5; //valores originales del 1 al 30
	pyFreq2 = msg[3].asFloat/5;//valores originales del 1 al 100 milisegundos
	//py = msg[4];//valores originales del 1 al 8
	( "/raspi3/modFreq " + pymodFreq ).postln;
	( "/raspi3/freq1 " + pyFreq1 ).postln;
	( "/raspi3/freq2 " + pyFreq2 ).postln;
	//( "channel is " + pyOut).postln;
	g.set(\modFreq,pymodFreq, \freq1,pyFreq1, \freq2,pyFreq2
		 );
}, '/raspi3/' );
};
)


(
w=Window.new.front;
v=UserView(w, w.view.bounds.insetBy(50,50));
v.resize = 5;
v.background_(Color.rand);
v.drawFunc={|uview|
        Button.new(w,Rect(10,10,180,30)).states_([["Inicio"]]).action_(~servidor);
	    Button.new(w,Rect(10,40,180,30)).states_([["SintesAdd"]]).action_(~sintesplay);
	    Button.new(w,Rect(10,70,180,30)).states_([["OscResp"]]).action_(~responder1);

l = s.volume;
l.min;
l.max;
l.volume = rrand(-50, 5);
l.setVolumeRange(-90, 8);
l.mute;
l.unmute;
l.gui;

};
)