
#declare XMAX=1.8;
#declare XMIN=-XMAX;
#declare YMAX=1.2;
#declare YMIN=-YMAX;

#include "lights.inc"
#declare ShipThrust = 1;
#include "ship.inc"

#declare Spike =
cone {
	<0, 1.3, 0>, 0
	<0, 0, 0>, 0.1 + 0.2 * sin(pi * (2 * clock - 1))
}

#declare spikes = 360/5;

# declare Star =
union {
	sphere {
		<0, 0, 0>, 0.3
	}
	#declare turn = 0;
	#while (turn < 360)
	object {
		Spike
		rotate z * turn
	}
	#declare turn = turn + spikes;
	#end

	scale <0.25, 0.25, 0.25>
	rotate -360 * clock * z
}


#if (clock < 0.9)
object {
	Ship
	rotate -40 * x
	rotate -120 *clock * z
	scale 1 - clock/2
	scale <1, 1-clock, 1>
	scale <pow(0.9 + clock, 2), 1, 1>
	translate -0.5 * clock * x
}
#end

#if (clock >= 0.5)
union {
	object {
		Star
		scale <1, 1, 0.1>
		pigment { rgbt <0.7, 0.7, 0.5, clock> }
	}
	object {
		Star
		scale 0.4 + clock/4
		pigment { rgb <2, 2, 1.5> }
	}
	scale 1 + sin(pi * (2 * clock - 1))
	translate (0.5 + clock) * x
}
#end

camera {
	orthographic
	up y*(YMAX - YMIN)
	right x*(XMAX - XMIN)
	location <(XMAX + XMIN)/2,(YMAX + YMIN)/2,-5>
	look_at  <(XMAX + XMIN)/2,(YMAX + YMIN)/2,0>
	#if (clock < 0.8)
	normal {
		// been drinking again?
		waves 0.1 * (clock/3 + 0.2)
		phase pi * clock
		frequency 8
	}
	#end
}
