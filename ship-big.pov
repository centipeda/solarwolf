
#declare XMAX=1.25;
#declare XMIN=-XMAX;
#declare YMAX=1.25;
#declare YMIN=-YMAX;

#include "camera-ortho.inc"
#include "lights.inc"
#declare ShipThrust = 1;
#include "ship.inc"

object {
	Ship
	rotate -10 * z
	rotate -20 * y
	rotate -50 * x
	translate -0.1 * y
}
