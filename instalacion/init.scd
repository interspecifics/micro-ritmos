(

~path = thisProcess.nowExecutingPath.dirname ++ "/";

(~path ++ "boot.scd").loadPaths;
(~path ++ "synths.scd").loadPaths;
(~path ++ "responders.scd").loadPaths;
(~path ++ "prueba.scd").loadPaths;


w=Window.new.front;
v=UserView(w, w.view.bounds.insetBy(50,50));
v.resize = 5;
v.background_(Color.rand);

v.drawFunc={|uview|

	~btn1=Button.new( w, Rect(10,10,180,30)).states_([["Preparar"]]).action_( ~boot_server );

	~btn2=Button.new( w, Rect(10,40,180,30)).states_([["Cargar sonidos"]]).action_( ~load_synths );

	~btn3=Button.new( w, Rect(10,70,180,30)).states_([["Iniciar instalación"]]).action_( ~start_responders );

	~btn4=Button.new( w, Rect(10,170,180,30)).states_([["Correr prueba"]]).action_( ~start_test);
	~btn5=Button.new( w, Rect(200,170,180,30)).states_([["Detener Prueba"]]).action_( ~stop_test );


	~btn2.visible = false;
	~btn3.visible = false;
	~btn4.visible = false;
	~btn5.visible = false;


};
)
