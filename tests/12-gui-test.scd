(

var btn1, btn2, btn3;

var function1, function2, function3;

function1 = {

	o = Server.local.options; ////variable para cambios en el servidor
	o.numOutputBusChannels = 8; //setea 8 canales 8 de salida ANTES DE BOOTEAR!!
	o.numOutputBusChannels.postln;/// imprime canales de salida habilitados
	o.device = "MOTU 896mk3 Hybrid"; //setea tarjeta de audio
	o.outDevice.postln; //imprimir dispositivo de salida
	s.boot; ///bootear servidos

	s.doWhenBooted({
		btn2.visible = true;
		btn3.visible = true;
	});
};



function2 = {
	"test2".postln;
};


w=Window.new.front;
v=UserView(w, w.view.bounds.insetBy(50,50));
v.resize = 5;
v.background_(Color.rand);

v.drawFunc={|uview|

	btn1=Button.new(w,Rect(10,10,180,30)).states_([["Iniciar"]]).action_(function1);

	btn2=Button.new(w,Rect(10,40,180,30)).states_([["test2"]]).action_(function2);

	btn3=Button.new(w,Rect(10,70,180,30)).states_([["test3"]]).action_(function3);

	btn2.visible = false;
	btn3.visible = false;

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
