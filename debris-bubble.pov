
#declare XMAX=1;
#declare XMIN=-XMAX;
#declare YMAX=1;
#declare YMIN=-YMAX;

#include "camera-ortho.inc"
#include "lights.inc"
#include "ship.inc"

object {
	Bubble
	pigment {
		#declare Compensation = (<1,1,1,0.4> - BubbleColor) * 2;
		color BubbleColor + clock * Compensation
	}
	finish { BubbleFinish }

	// animate
	rotate -90 * x
	scale (1 - 0.5*clock) * z
	rotate clock * 180 * y
	rotate clock * 360 * z
}
