/*
 * A shield "robot" orbiting the ship
 *
 * (w) 2004 by Eero Tamminen
 */

#declare XMAX=1.1;
#declare XMIN=-XMAX;
#declare YMAX=1.1;
#declare YMIN=-YMAX;

#include "camera-ortho.inc"
#include "lights.inc"


union {
	sphere {
		0, 0.7
		pigment { rgb 0.6 + clock * 0.4	}
	}
	#if (clock >= 0.3)
	cylinder {
		<0, 0, -0.2>, <0, 0, 0.2>, 1.1
		pigment { rgb <clock, 0, 0> }
	}
	#end
}
