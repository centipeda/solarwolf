
#declare XMAX=1.2;
#declare XMIN=-XMAX;
#declare YMAX=1.2;
#declare YMIN=-YMAX;

#include "camera-ortho.inc"
#include "lights.inc"
#include "ship.inc"
#include "teleport.inc"

object {
	Teleport
	rotate -90 * x
}

object {
	Ship
#if (clock = 0.25)
	scale 0.01
#else
	scale 1/3 + 2*(2*clock-1)/3
#end
	rotate -40 * x
	rotate 360 * 2 * clock * z
}
