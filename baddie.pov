/* 
 * An animated firing enemy for solarwolf game
 *
 * (w) 2003 by Eero Tamminen
 */

#declare XMAX=8.2;
#declare XMIN=-XMAX;
#declare YMAX=4.1;
#declare YMIN=-YMAX;

#include "camera-ortho.inc"
#include "lights.inc"

#include "baddie.inc"
#include "fire.inc"

#declare Electric =
cylinder {
	<0, 0, 0>, <0, 1 + 7 * sin(pi * clock), 0>, 1
	pigment {
		color rgbf <1, 1, 1, 1>
	}
	finish { ambient 0 diffuse 0 }
	interior {
		media {
			samples 1, 10
			emission 1
			density {
				cylindrical
				color_map {
					[ 0.0 color rgbt <0, 0, 0, 1> ]
					[ 0.4 color rgbt <0, 0, 1, 0.5> ]
					[ 0.8 color rgb  <0, 1, 1> ]
					[ 1.0 color rgb  <2, 2, 2> ]
				}
				turbulence 0.6
			}
			scale 0.5
		}
	}
	rotate 360 * clock * y
	scale <0.8, 1, 0.8>
	hollow
}

#declare HeadRotate = -50 * (1 - sin(pi * clock));
#declare ArmDetract = 5.3 + 1.3 * sin(pi * clock);

union {
#if (clock < 0.5)
	union {
		object {
			Electric
			rotate (20 + 35 * sin(pi*clock)) * z
		}
		object {
			Electric
			rotate -(20 + 35 * sin(pi*clock)) * z
		}
		translate 2 * y
	}
#else
#if (clock < 0.9)
	object {
		Fire
		scale 4 * clock
		translate 4 * y
	}
#end
#end
	union {
		object {
			Head
			rotate HeadRotate * z
		}
		object {
			Arm
		}
		translate -ArmDetract * x
	}
	object {
		Trunk
	}
	union {
		object {
			Head
			rotate HeadRotate * z
		}
		object {
			Arm
		}
		rotate 180 * y
		translate ArmDetract * x
	}
	texture {
		BaddieTexture
	}
	// center
	translate -2.3 * y
}
