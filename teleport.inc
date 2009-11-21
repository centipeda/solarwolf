/* 
 * Teleport effect for Solarwolf:
 * - A blue halo that flashes on the first half
 * - A red ring that flashes during whole thing
 * 
 * (w) 2003 by Eero Tamminen
 */

#declare Teleport =
union {
	#if (clock < 0.5)
	sphere {
		0, 1
		pigment {
			color rgbf <1, 1, 1, 1>
		}
		finish { ambient 0 diffuse 0 }
		interior {
			media {
				samples 1, 10
				emission 1
				density {
					spherical
					color_map {
						[ 0.0 color rgbt <0, 0, 0, 1> ]
						[ 1.0 color rgb  <clock, clock, 1> ]
					}
				}
				scale 0.6 * sin(pi*(clock + 0.25))
			}
		}
		hollow
		scale 2
	}
	#end
	#if (clock <= 0.9)
	torus {
		1, 0.1
		pigment { rgbt <2, 0, 0, 1 - sin(pi*(clock*1/0.9)) > }
	}
	#end
}
