~boot_server = {

	o = Server.local.options; ////variable para cambios en el servidor
	o.numOutputBusChannels = 8; //setea 8 canales 8 de salida ANTES DE BOOTEAR!!
	o.numOutputBusChannels.postln;/// imprime canales de salida habilitados
	o.device = "MOTU 896mk3 Hybrid"; //setea tarjeta de audio
	o.outDevice.postln; //imprimir dispositivo de salida
	s.boot; ///bootear servidos

	s.doWhenBooted({
		~btn2.visible = true;
		~btn3.visible = true;
		l = s.volume;
		l.min;
		l.max;
		l.volume = rrand(-50, 5);
		l.setVolumeRange(-90, 8);
		l.mute;
		l.unmute;
		l.gui;
	});
};