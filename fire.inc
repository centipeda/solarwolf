/* 
 * An animated fire / flame.
 *
 * (w) 2002 by Eero Tamminen
 */

#declare Fire =
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
					[ 0.1 color rgbt <1, 0, 0, 0.5> ]
					[ 0.4 color rgb  <2, 1, 0> ]
					[ 0.8 color rgb  <2, 2, 0> ]
					[ 1.0 color rgb  <2, 2, 2> ]
				}
				//turbulence 0.3 + 1.2 * clock
				turbulence 0.4 + 0.1 * sin(clock*pi)
			}
			scale 0.5
		}
	}
	hollow
	//scale 1 - 0.2 * sin(clock*pi)
	rotate <360 * clock, -360 * clock, 260 * clock>
}
