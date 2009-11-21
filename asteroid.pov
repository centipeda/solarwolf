/*
 * A rotating pockmarked asteroid for Solarwolf game
 *
 * (w) 2003 by Eero Tamminen
 */

#declare XMAX=12;
#declare XMIN=-XMAX;
#declare YMAX=12;
#declare YMIN=-YMAX;

#include "camera-ortho.inc"
#include "lights.inc"

#declare I = seed(731);

#macro spheres(cnt, r, dmin, dmax)
	#while (cnt > 0)
	sphere {
		0, r
		translate (dmin + (dmax - dmin) * rand(I)) * x
		rotate <rand(I)*360, rand(I)*360, rand(I)*360>
	}
	#declare cnt = cnt - 1;
	#end
#end


difference {
	union {
		// item material
		spheres(10, 6, 4.4, 5)
		spheres(8, 7, 4, 4.6)
	}
	union {
		// holes in the material
		spheres(10, 8, 16, 17)
		spheres(16, 3, 11.5, 12.5)
		spheres(24, 2, 10.5, 11.5)
	}
	pigment { rgb 1 }
	normal {
		wrinkles 0.5
		turbulence 0.5
		scale 3
	}
	finish {
		phong 1
		phong_size 40
		metallic
		ambient 0.2
	}

	// animation
	rotate <clock*360, clock*360, 0>
}
