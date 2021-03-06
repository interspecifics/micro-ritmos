~start_responders  = {
	"iniciar instalación".postln;




	~lastTime = Array.fill(3,0);


	// almacenar los nombres de los synths en los siguientes arrays:

	~pi1_synth_names = [
		\pi1_synth1,
		\pi1_synth2,
		\pi1_synth3,
		\pi1_synth4,
		\pi1_synth5,
		\pi1_synth6
	];
	~pi2_synth_names = [
		\pi2_synth1,
		\pi2_synth2,
		\pi2_synth3,
		\pi2_synth4,
		\pi2_synth5,
		\pi2_synth6
	];
	~pi3_synth_names = [
		\pi3_synth1,
		\pi3_synth2,
		\pi3_synth3,
		\pi3_synth4,
		\pi3_synth5,
		\pi3_synth6
	];


	~pi_synth_names = Dictionary.new();
	~synths = Dictionary.new();

	~pi_synth_names[1] = ~pi1_synth_names;
	~pi_synth_names[2] = ~pi2_synth_names;
	~pi_synth_names[3] = ~pi3_synth_names;

	~synths[1] = Dictionary.new();
	~synths[2] = Dictionary.new();
	~synths[3] = Dictionary.new();

	// crear responders para cada una de las pis:


	// PI 1:

	OSCFunc.newMatching({ | msg, time, addr, port |

		var pi_id = 1;

		var synth_id, param1, param2, out_channel;

		synth_id    = msg[1].asInteger;
		param1      = msg[2].asInteger;
		param2      = msg[3].asFloat;
		out_channel = msg[4].asInteger;


		~this_pi_synths = ~pi_synth_names[pi_id];

		if( Main.elapsedTime - ~lastTime[pi_id-1] > 0.5, {



			if( synth_id != nil, {
				~synth_name = ~pi_synth_names[ pi_id ][ synth_id ];

				( "OSCFunc " ++ pi_id ++ " plays: " ++ ~synth_name ).postln;
				"".postln;


				if( ~synths[ pi_id ][ synth_id ].isPlaying == false, {
					("synth " ++ ~synth_name ++" not playing. Start it").postln;

					~synths[ pi_id ][ synth_id ] = Synth(
						~synth_name,
						[
							freq: param1,
							dur: param2,
							out: out_channel % ~num_outs
					]);
					NodeWatcher.register( ~synths[ pi_id ][ synth_id ] );
					},{ // else
						~synths[ pi_id ][ synth_id ].set(\freq, param1 );
						~synths[ pi_id ][ synth_id ].set(\dur, param2 );
						~synths[ pi_id ][ synth_id ].set(\out, out_channel % ~num_outs );

				});

				~lastTime[pi_id-1] = Main.elapsedTime;

			}, {});

			},{

		});



	}, '/raspi1/' );



	// PI 2:

	OSCFunc.newMatching({ | msg, time, addr, port |

		var pi_id = 2;

		var synth_id, param1, param2, out_channel;

		synth_id    = msg[1].asInteger;
		param1      = msg[2].asInteger;
		param2      = msg[3].asFloat;
		out_channel = msg[4].asInteger;


		~this_pi_synths = ~pi_synth_names[pi_id];

		if( Main.elapsedTime - ~lastTime[pi_id-1] > 0.5, {



			if( synth_id != nil, {
				~synth_name = ~pi_synth_names[ pi_id ][ synth_id ];

				( "OSCFunc " ++ pi_id ++ " plays: " ++ ~synth_name ).postln;
				"".postln;


				if( ~synths[ pi_id ][ synth_id ].isPlaying == false, {
					("synth " ++ ~synth_name ++" not playing. Start it").postln;

					~synths[ pi_id ][ synth_id ] = Synth(
						~synth_name,
						[
							freq: param1,
							dur: param2,
							out: out_channel % ~num_outs
					]);
					NodeWatcher.register( ~synths[ pi_id ][ synth_id ] );
					},{ // else
						~synths[ pi_id ][ synth_id ].set(\freq, param1 );
						~synths[ pi_id ][ synth_id ].set(\dur, param2 );
						~synths[ pi_id ][ synth_id ].set(\out, out_channel % ~num_outs );

				});

				~lastTime[pi_id-1] = Main.elapsedTime;

			}, {});

			},{

		});


	}, '/raspi2/' );



	// PI 3:

	OSCFunc.newMatching({ | msg, time, addr, port |

		var pi_id = 3;

		var synth_id, param1, param2, out_channel;

		synth_id    = msg[1].asInteger;
		param1      = msg[2].asInteger;
		param2      = msg[3].asFloat;
		out_channel = msg[4].asInteger;


		~this_pi_synths = ~pi_synth_names[pi_id];

		if( Main.elapsedTime - ~lastTime[pi_id-1] > 0.5, {



			if( synth_id != nil, {
				~synth_name = ~pi_synth_names[ pi_id ][ synth_id ];

				( "OSCFunc " ++ pi_id ++ " plays: " ++ ~synth_name ).postln;
				"".postln;


				if( ~synths[ pi_id ][ synth_id ].isPlaying == false, {
					("synth " ++ ~synth_name ++" not playing. Start it").postln;

					~synths[ pi_id ][ synth_id ] = Synth(
						~synth_name,
						[
							freq: param1,
							dur: param2,
							out: out_channel % ~num_outs
					]);
					NodeWatcher.register( ~synths[ pi_id ][ synth_id ] );
					},{ // else
						~synths[ pi_id ][ synth_id ].set(\freq, param1 );
						~synths[ pi_id ][ synth_id ].set(\dur, param2 );
						~synths[ pi_id ][ synth_id ].set(\out, out_channel % ~num_outs );

				});

				~lastTime[pi_id-1] = Main.elapsedTime;


			}, {});

			},{

		});


	}, '/raspi3/' );



	~btn4.visible = true;
	~btn5.visible = true;

};