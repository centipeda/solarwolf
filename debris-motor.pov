
#declare XMAX=1.1;
#declare XMIN=-XMAX;
#declare YMAX=1.1;
#declare YMIN=-YMAX;

#include "camera-ortho.inc"
#include "lights.inc"
#include "ship.inc"

object {
	Motor
	/* Note: I cannot use finish with highlights with the
	 * seethrough (rgbf 1) color emulating missing parts,
	 * so I make Motor color brighter
	 */
	pigment {
		brick rgbf 1, MotorColor * 1.2
		brick_size 1
		mortar 0.1 + clock*clock/2
		turbulence 0.2
		scale 0.5
	}

	// center
	rotate -90 * x
	scale 3.5
	translate -0.7 * y

	// animate
	rotate clock * 180 * y
	rotate clock * 360 * z
}
