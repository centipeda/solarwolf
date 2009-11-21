/* 
 * An animated teleporting enemy for solarwolf game
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
#include "teleport.inc"

object {
	Teleport
	scale 3.5
	rotate -90 * x
}

#declare HeadRotate = -50 * clock;
#declare ArmRotate  = 360 * clock;
#declare ArmDetract = 6.6 - 1.3 * clock;

union {
	union {
		object {
			Head
			rotate HeadRotate * z
		}
		object {
			Arm
		}
		rotate -ArmRotate * x
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
		rotate ArmRotate * x
		translate ArmDetract * x
	}
	texture {
		BaddieTexture
	}
	// center
	translate -2.3 * clock * y
	
#if (clock = 0.25)
	scale 0.01
#else
	// teleport in (scale/rotate)
	scale 1/3 + 2*(2*clock-1)/3
#end
#if (clock <= 2/3)
	rotate 360 * 3 * clock * z
#end
}
