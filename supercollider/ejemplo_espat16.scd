

// El Cubito de Chuito/ Chuito's Cube for 3D Sound.  Roy F Guzmán www.roy-guzman.com
copyright # 3MOT-HUIF-F3ZN-VU3V

// Instantiate as many SynthDefs as there are sound sources. The more SyntheDefs the more sources, the more sounds to produce a illusion of trajectories that when aching a liminal point of 60HZ± of velocity can achieve an illusion or an intent to create sound forms. Now the coordinates are only the simple logistic map for x, y, z, all of them in different indexes and variable institution for the rout to not be linear. Explore with any other function or SynthDef like Sines, LFNoise1, Saw, Chaotic Functions and any other available signal producing Ugen.

Server.local.options.device = "Built-In-Audio";
Server.internal.options.device = "Built-In-Audio";
ServerOptions.outDevices;
Server.default.options.outDevice_("Built-In-Audio");

s.options.numOutputBusChannels;
s.options.numOutputBusChannels = 16;


s = Server.local;
s.makeGui;
s.meter;


(
~jesus = Bus.audio(s, 1);
~source1 = Bus.audio(s, 1);
~source2 = Bus.audio(s, 1);
~mult0 = Bus.audio(s, 1);
~mult1 = Bus.audio(s, 1);
~mult2 = Bus.audio(s, 1);
~mult3 = Bus.audio(s, 1);
~mult4 = Bus.audio(s, 1);
~mult5 = Bus.audio(s, 1);
~mult6 = Bus.audio(s, 1);
~mult7 = Bus.audio(s, 1);
//~mult8 = Bus.audio(s, 1);
//~mult9 = Bus.audio(s, 1);
//~mult10 = Bus.audio(s, 1);
//~mult11 = Bus.audio(s, 1);
//~mult12 = Bus.audio(s, 1);
//~mult13 = Bus.audio(s, 1);
//~mult14 = Bus.audio(s, 1);
)

(
SynthDef(\ChuitoSpat14, { arg mult0 = 16, mult1 = 17, mult2 = 18,
	mult3 = 19, mult4 = 20, mult5 = 21, mult6 = 22,
	mult7 = 23, mult8 = 24, mult9 = 25, mult10 = 26,
	mult11 = 27, mult12 = 28, mult13 = 29, source = 34;
	var out0 = 0, out1 = 1, out2 = 2, out3 = 3, out4 = 4, out5 = 5, out6 = 6, out7 = 7;
	var out8 = 8, out9 = 9, out10 = 10, out11 = 11, out12 = 12, out13 = 13, out14 = 14;
	var sig0, sig1, sig2, sig3, sig4, sig5, sig6, sig7, sig8, sig9, sig10, sig11, sig12, sig13, sig14;
	sig0 = (In.ar(mult0, 1) * In.ar(source, 1));
	sig1 = (In.ar(mult1, 1) * In.ar(source, 1));
	sig2 = (In.ar(mult2, 1) * In.ar(source, 1));
	sig3 = (In.ar(mult3, 1) * In.ar(source, 1));
	sig4 = (In.ar(mult4, 1) * In.ar(source, 1));
	sig5 = (In.ar(mult5, 1) * In.ar(source, 1));
	sig6 = (In.ar(mult6, 1) * In.ar(source, 1));
	sig7 = (In.ar(mult7, 1) * In.ar(source, 1));
	sig8 = (In.ar(mult8, 1) * In.ar(source, 1));
	sig9 = (In.ar(mult9, 1) * In.ar(source, 1));
	sig10 = (In.ar(mult10, 1) * In.ar(source, 1));
	sig11 = (In.ar(mult11, 1) * In.ar(source, 1));
	sig12 = (In.ar(mult12, 1) * In.ar(source, 1));
	sig13 = (In.ar(mult13, 1) * In.ar(source, 1));
	Out.ar(0, sig0);
	Out.ar(1, sig1);
	Out.ar(2, sig2);
	Out.ar(3, sig3);
	Out.ar(4, sig4);
	Out.ar(5, sig5);
	Out.ar(6, sig6);
	Out.ar(7, sig7);
	Out.ar(8, sig8);
	Out.ar(9, sig9);
	Out.ar(10, sig10);
	Out.ar(11, sig11);
	Out.ar(12, sig12);
	Out.ar(13, sig13);
	}).send(s);
)


(
~g1 = 0.0;
~g2 = 0.0;
~g3 = 0.0;
~g4 = 0.0;
~g5 = 0.0;
~g6 = 0.0;
~g7 = 0.0;
~g8 = 0.0;
~g9 = 0.0;
~g10 = 0.0;
~g11 = 0.0;
~g12 = 0.0;
~g13 = 0.0;
~g14 = 0.0;
SynthDef(\ElCubitodeChuito, {
var samplerate = 44100, sampx, sampy, sampz;
var x0 = 0.1, x1, y0, x2, logx, ampx;
var x00 = 0.1, x11, y00, x22, logy, ampy;
var x000 = 0.1, x111, y000, x222, logz, ampz;
var cvar0 = 3.8, cvar00/* = 3.99*/, cvar000;
var b0, b1, b2;
var brampx, brampy, brampz;
var buntx, bunty, buntz;
var maxsamp;
var int1, int2, int3, int4, int5, int6, int7, int8, int9, int10, int11, int12, int13, int14;
var x0x, y0x, y1x, ax;
var x0y, y0y, y1y, ay;
var x0z, y0z, y1z, az;
var speaker1x = 0.0, speaker1y = 1.0, speaker1z = 0.0, spik1, speaker1;//Left Back Up
var speaker2x = 1.0, speaker2y = 1.0, speaker2z = 0.0, spik2, speaker2;// Right Back Up
var speaker3x = 0.0, speaker3y = 1.0, speaker3z = 1.0, spik3, speaker3;// Left Front Up
var speaker4x = 1.0, speaker4y = 1.0, speaker4z = 1.0, spik4, speaker4;// Right Front UP
var speaker5x = 0.0, speaker5y = 0.0, speaker5z = 0.0, spik5, speaker5;// Left Back Down
var speaker6x = 1.0, speaker6y = 0.0, speaker6z = 0.0, spik6, speaker6;// Right Back Down
var speaker7x = 0.0, speaker7y = 0.0, speaker7z = 1.0, spik7, speaker7;// Left Front Down
var speaker8x = 1.0, speaker8y = 0.0, speaker8z = 1.0, spik8, speaker8;// Right Front Down
var speaker9x = 0.0, speaker9y = 0.5, speaker9z = 0.5, spik9, speaker9;// Center Left
var speaker10x = 1.0, speaker10y = 0.5, speaker10z = 0.5, spik10, speaker10;// Center Right
var speaker11x = 0.5, speaker11y = 0.5, speaker11z = 0.0, spik11, speaker11;// Center Back
var speaker12x = 0.5, speaker12y = 0.5, speaker12z = 1.0, spik12, speaker12;// Center Front
var speaker13x = 0.5, speaker13y = 1.0, speaker13z = 0.5, spik13, speaker13;// Center UP
var speaker14x = 0.5, speaker14y = 0.0, speaker14z = 0.5, spik14, speaker14;// Center Down
var nspeakers = 14;
var listeningthreshold, range = 0.5 /* 0.25 - 2/3 */;
var offsetx, offsety, offsetz;
var e = 2.7182818284590452353602874713527, width = 0.01; /*0.001 - > 0.09 */
var d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14;
var g1, g2, g3, g4;
var out1, out2, out3, out4;

    b0 = LocalBuf(1);
	b1 = LocalBuf(1);
	b2 = LocalBuf(1);

	listeningthreshold = 60;

	//
	// // Use any In.ar(....) here or any Bus from outside to produce the x coordinate from 0 to 1.
	//
	// For now is just a logistic function in order to produce an x coordinate path with the Logistic Map

	sampx = 0.5;
	cvar0 = 3.3;
	b0 = LocalBuf(1);
	x0 = Dbufrd(b0); // read from buffe
	x1 = (cvar0*(x0+0.00001)) * (1 - (x0+0.00001));
	x0 = x1;
	y0 = Dbufwr(x1, b0); // write to buffer
	logx = Duty.ar(1/sampx, 0, (y0 * 0.5));

    //
	// Use any In.ar(....) here or any Bus from outside to produce the y coordinate from 0 to 1.
	//
	// For now is just a logistic function in order to produce an x coordinate path with the Logistic Map

	sampy = sampx;
	cvar00 = 3.3;
	b1 = LocalBuf(1);
	x00 = Dbufrd(b1); // read from buffe
	x11 = (cvar00*(x00+0.00001)) * (1 - (x00+0.00001));
	x00 = x11;
	y00 = Dbufwr(x11, b1); // write to buffer
	logy = Duty.ar(1/sampy, 0, y00);

	//
	// Use any In.ar(....) here or any Bus from outside to produce the z coordinate from 0 to 1.
	//
	// For now is just a logistic function in order to produce an z coordinate path with the Logistic Map

	sampz = sampx;
	cvar000 = 3.3;
	b2 = LocalBuf(1);
	x000 = Dbufrd(b2); // read from buffe
	x111 = (cvar000*(x000+0.00001)) * (1 - (x000+0.00001));
	x000 = x111;
	y000 = Dbufwr(x111, b2); // write to buffer
	logz = Duty.ar(1/sampz, 0, y000);

	// Distance Formula

	int1 = Ramp.ar(((((logx-speaker1x)**2)+((logy - speaker1y)**2)+
		((logz - speaker1z)**2)).sqrt).linlin(0.0,1.7320508075689,0.0,1.0),1/sampx);
	int2 = Ramp.ar(((((logx-speaker2x)**2)+((logy - speaker2y)**2)+
		((logz - speaker2z)**2)).sqrt).linlin(0.0,1.7320508075689,0.0,1.0),1/sampx);
	int3 = Ramp.ar(((((logx-speaker3x)**2)+((logy - speaker3y)**2)+
		((logz - speaker3z)**2)).sqrt).linlin(0.0,1.7320508075689,0.0,1.0),1/sampx);
	int4 = Ramp.ar(((((logx-speaker4x)**2)+((logy - speaker4y)**2)+
		((logz - speaker4z)**2)).sqrt).linlin(0.0,1.7320508075689,0.0,1.0),1/sampx);
	int5 = Ramp.ar(((((logx-speaker5x)**2)+((logy - speaker5y)**2)+
		((logz - speaker5z)**2)).sqrt).linlin(0.0,1.7320508075689,0.0,1.0),1/sampx);
	int6 = Ramp.ar(((((logx-speaker6x)**2)+((logy - speaker6y)**2)+
		((logz - speaker6z)**2)).sqrt).linlin(0.0,1.7320508075689,0.0,1.0),1/sampx);
	int7 = Ramp.ar(((((logx-speaker7x)**2)+((logy - speaker7y)**2)+
		((logz - speaker7z)**2)).sqrt).linlin(0.0,1.7320508075689,0.0,1.0),1/sampx);
	int8 = Ramp.ar(((((logx-speaker8x)**2)+((logy - speaker8y)**2)+
		((logz - speaker8z)**2)).sqrt).linlin(0.0,1.7320508075689,0.0,1.0),1/sampx);
	int9 = Ramp.ar(((((logx-speaker9x)**2)+((logy - speaker9y)**2)+
		((logz - speaker9z)**2)).sqrt).linlin(0.0,1.7320508075689,0.0,1.0),1/sampx);
	int10 = Ramp.ar(((((logx-speaker10x)**2)+((logy - speaker10y)**2)+
		((logz - speaker10z)**2)).sqrt).linlin(0.0,1.7320508075689,0.0,1.0),1/sampx);
	int11 = Ramp.ar(((((logx-speaker11x)**2)+((logy - speaker11y)**2)+
		((logz - speaker11z)**2)).sqrt).linlin(0.0,1.7320508075689,0.0,1.0),1/sampx);
	int12 = Ramp.ar(((((logx-speaker12x)**2)+((logy - speaker12y)**2)+
		((logz - speaker12z)**2)).sqrt).linlin(0.0,1.7320508075689,0.0,1.0),1/sampx);
	int13 = Ramp.ar(((((logx-speaker13x)**2)+((logy - speaker13y)**2)+
		((logz - speaker13z)**2)).sqrt).linlin(0.0,1.7320508075689,0.0,1.0),1/sampx);
	int14 = Ramp.ar(((((logx-speaker14x)**2)+((logy - speaker14y)**2)+
		((logz - speaker14z)**2)).sqrt).linlin(0.0,1.7320508075689,0.0,1.0),1/sampx);


	//The one liner for amplitude distribution in space concerning distance.

	d1 = (((if(int1 > range, 0, if(int1>(range*0.5),(1-int1.linlin(0.0,range,0.0,1.0))**(1/2), (int1.linlin(0.0,range,0.0,1.0))))).linlin(0.0,0.5, 0.0,1)));
	d2 = (((if(int2 > range, 0, if(int2>(range*0.5),(1-int2.linlin(0.0,range,0.0,1.0))**(1/2), (int2.linlin(0.0,range,0.0,1.0))))).linlin(0.0,0.5, 0.0,1)));
	d3 = (((if(int3 > range, 0, if(int3>(range*0.5),(1-int3.linlin(0.0,range,0.0,1.0))**(1/2), (int3.linlin(0.0,range,0.0,1.0))))).linlin(0.0,0.5, 0.0,1)));
	d4 = (((if(int4 > range, 0, if(int4>(range*0.5),(1-int4.linlin(0.0,range,0.0,1.0))**(1/2), (int4.linlin(0.0,range,0.0,1.0))))).linlin(0.0,0.5, 0.0,1)));
	d5 = (((if(int5 > range, 0, if(int5>(range*0.5),(1-int5.linlin(0.0,range,0.0,1.0))**(1/2), (int5.linlin(0.0,range,0.0,1.0))))).linlin(0.0,0.5, 0.0,1)));
	d6 = (((if(int6 > range, 0, if(int6>(range*0.5),(1-int6.linlin(0.0,range,0.0,1.0))**(1/2), (int6.linlin(0.0,range,0.0,1.0))))).linlin(0.0,0.5, 0.0,1)));
	d7 = (((if(int7 > range, 0, if(int7>(range*0.5),(1-int7.linlin(0.0,range,0.0,1.0))**(1/2), (int7.linlin(0.0,range,0.0,1.0))))).linlin(0.0,0.5, 0.0,1)));
	d8 = (((if(int8 > range, 0, if(int8>(range*0.5),(1-int8.linlin(0.0,range,0.0,1.0))**(1/2), (int8.linlin(0.0,range,0.0,1.0))))).linlin(0.0,0.5, 0.0,1)));
	d9 = (((if(int9 > range, 0, if(int9>(range*0.5),(1-int9.linlin(0.0,range,0.0,1.0))**(1/2), (int9.linlin(0.0,range,0.0,1.0))))).linlin(0.0,0.5, 0.0,1)));
	d10 = (((if(int10 > range, 0, if(int10>(range*0.5),(1-int10.linlin(0.0,range,0.0,1.0))**(1/2), (int10.linlin(0.0,range,0.0,1.0))))).linlin(0.0,0.5, 0.0,1)));
	d11 = (((if(int11 > range, 0, if(int11>(range*0.5),(1-int11.linlin(0.0,range,0.0,1.0))**(1/2), (int11.linlin(0.0,range,0.0,1.0))))).linlin(0.0,0.5, 0.0,1)));
	d12 = (((if(int12 > range, 0, if(int12>(range*0.5),(1-int12.linlin(0.0,range,0.0,1.0))**(1/2), (int12.linlin(0.0,range,0.0,1.0))))).linlin(0.0,0.5, 0.0,1)));
	d13 = (((if(int13 > range, 0, if(int13>(range*0.5),(1-int13.linlin(0.0,range,0.0,1.0))**(1/2), (int13.linlin(0.0,range,0.0,1.0))))).linlin(0.0,0.5, 0.0,1)));
	d14 = (((if(int14 > range, 0, if(int14>(range*0.5),(1-int14.linlin(0.0,range,0.0,1.0))**(1/2), (int14.linlin(0.0,range,0.0,1.0))))).linlin(0.0,0.5, 0.0,1)));


	//// Just the Line

	~g1 = Out.ar(16,d1);
	~g2 = Out.ar(17,d2);
	~g3 = Out.ar(18,d3);
	~g4 = Out.ar(19,d4);
	~g5 = Out.ar(20,d5);
	~g6 = Out.ar(21,d6);
	~g7 = Out.ar(22,d7);
	~g8 = Out.ar(23,d8);
	~g9 = Out.ar(24,d9);
	~g10 = Out.ar(25,d10);
	~g11 = Out.ar(26,d11);
	~g12 = Out.ar(27,d12);
	~g13 = Out.ar(28,d13);
	~g14 = Out.ar(29,d14);



	/// Gaussian Curve
	// Optional Gaussian Curve if the perception of the distance is to linear or non natural. Open for musical expression
	// depending on the behaviour one wants. You can use other envelopes to distribute the amplitude in space regarding
	// your musical, perceptive, or research reason.
	//
	//Use the variables to produce the window depnding on the width of the funtion and its amplitude

	//
	// ~g1 = Out.ar(16,((2.5/(1*(2pi).sqrt))*(e**((((d1-0.5)**2)/((2*width)**2))* (-1)))).linlin(0.0,1.0,0.0,0.9));
	// ~g2 = Out.ar(17,((2.5/(1*(2pi).sqrt))*(e**((((d2-0.5)**2)/((2*width)**2))* (-1)))).linlin(0.0,1.0,0.0,0.9));
	// ~g3 = Out.ar(18,((2.5/(1*(2pi).sqrt))*(e**((((d3-0.5)**2)/((2*width)**2))* (-1)))).linlin(0.0,1.0,0.0,0.9));
	// ~g4 = Out.ar(19,((2.5/(1*(2pi).sqrt))*(e**((((d4-0.5)**2)/((2*width)**2))* (-1)))).linlin(0.0,1.0,0.0,0.9));
	// ~g5 = Out.ar(20,((2.5/(1*(2pi).sqrt))*(e**((((d5-0.5)**2)/((2*width)**2))*
	// (-1)))).linlin(0.0,1.0,0.0,0.9));
	// ~g6 = Out.ar(21,((2.5/(1*(2pi).sqrt))*(e**((((d6-0.5)**2)/((2*width)**2))*
	// (-1)))).linlin(0.0,1.0,0.0,0.9));
	// ~g7 = Out.ar(22,((2.5/(1*(2pi).sqrt))*(e**((((d7-0.5)**2)/((2*width)**2))*
	// (-1)))).linlin(0.0,1.0,0.0,0.9));
	// ~g8 = Out.ar(23,((2.5/(1*(2pi).sqrt))*(e**((((d8-0.5)**2)/((2*width)**2))*
	// (-1)))).linlin(0.0,1.0,0.0,0.9));
	// ~g9 = Out.ar(24,((2.5/(1*(2pi).sqrt))*(e**((((d9-0.5)**2)/((2*width)**2))*
	// (-1)))).linlin(0.0,1.0,0.0,0.9));
	// ~g10 = Out.ar(25,((2.5/(1*(2pi).sqrt))*(e**((((d10-0.5)**2)/((2*width)**2))*
	// (-1)))).linlin(0.0,1.0,0.0,0.9));
	// ~g11 = Out.ar(26,((2.5/(1*(2pi).sqrt))*(e**((((d11-0.5)**2)/((2*width)**2))*
	// (-1)))).linlin(0.0,1.0,0.0,0.9));
	// ~g12 = Out.ar(27,((2.5/(1*(2pi).sqrt))*(e**((((d12-0.5)**2)/((2*width)**2))*
	// (-1)))).linlin(0.0,1.0,0.0,0.9));
	// ~g13 = Out.ar(28,((2.5/(1*(2pi).sqrt))*(e**((((d13-0.5)**2)/((2*width)**2))*
	// (-1)))).linlin(0.0,1.0,0.0,0.9));
	// ~g14 = Out.ar(29,((2.5/(1*(2pi).sqrt))*(e**((((d14-0.5)**2)/((2*width)**2))*
	// (-1)))).linlin(0.0,1.0,0.0,0.9));

    /// Sine curve y otros

};
).add;
)

~noise = {Out.ar(34,WhiteNoise.ar(1))}.play


~spat = Synth(\ChuitoSpat14);

~xyz = Synth(\ElCubitodeChuito);

