/*
 * A spiked ball for the Solarwolf game
 *
 * (w) 2003 by Eero Tamminen
 */

#declare XMAX=1.1;
#declare XMIN=-XMAX;
#declare YMAX=1.1;
#declare YMIN=-YMAX;

#include "camera-ortho.inc"
#include "lights.inc"


#declare spike =
cone {
	<0,  0.9, 0>, 0
	<0, -0.1, 0>, 0.5
	scale 0.4
	translate 0.8 * y
}

// spikeball
union {
	// ball
	sphere {
		<0, 0, 0>, 0.8
	}

	// top spike
	object {
		spike
	}

	// top ring of spikes
	#declare turn = 0;
	#while (turn < 360)
	object {
		spike
		rotate z * 45
		rotate y * turn
	}
	#declare turn = turn + 90;
	#end
	
	// middle ring of spikes
	#declare turn = 0;
	#while (turn < 360)
	object {
		spike
		rotate z * 90
		rotate y * turn
	}
	#declare turn = turn + 45;
	#end

	// bottom ring of spikes
	#declare turn = 0;
	#while (turn < 360)
	object {
		spike
		rotate z * 135
		rotate y * turn
	}
	#declare turn = turn + 90;
	#end
	
	// bottom spike
	object {
		spike
		rotate z * 180
	}

	pigment { rgb 1 }
	normal {
		waves 0.6
		turbulence 1.5
		scale 0.7
	}
	finish {
		metallic
		phong 1
		phong_size 20
		// without brilliance this is much lighter
		brilliance 2
	}

	// animation
	rotate <90*sin(clock*pi), 90*cos(clock*pi)> //, 90*sin(clock*pi)>
}
