/* Small animated explosion which can be superimposed to make
 * huge explosions.
 *
 * (w) 2002 by Eero Tamminen
 */

union {
#include "explosion.inc"

	texture {
		pigment {
			spherical
			color_map {
				[ 0.0 color rgb <0, 0, 0> ]
				[ 0.3 color rgb <1, 0.5, 0> ]
				[ 0.5 color rgb <1, 1, 0> ]
				[ 0.7 color rgb <1, 0.5, 0> ]
				[ 0.9 color rgb <2, 1, 0.5> ]
				[ 1.0 color rgb <2, 2, 2> ]
			}
			scale 2
			turbulence 0.8
			phase (1 - clock) * 0.4
			rotate clock * 90 * y
		}
	}
	finish {
	       ambient 1
	}
	rotate -clock * 90 * y
}

camera {
        // use 1/1 aspect ratio
	right x

	location <0, 0, -5>
	look_at <0, 0, 0>
}
