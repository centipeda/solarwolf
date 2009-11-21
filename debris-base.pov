
#declare XMAX=1.2;
#declare XMIN=-XMAX;
#declare YMAX=1.2;
#declare YMIN=-YMAX;

#include "camera-ortho.inc"
#include "lights.inc"
#include "ship.inc"

// seed for random generator
#declare I = seed(5643);

#declare Holes =
union {
	#declare cnt = 8; // * clock;
	#while (cnt > 0)
	box {
		// make hole into ship with SZ sized box
		#declare SZ = 0.1 + 0.5*clock;
		<-SZ, -SZ, -SZ>, <SZ, SZ, SZ>
		
		// rotate the box
		rotate <rand(I)*360, rand(I)*360, rand(I)*360>
		
		// distance with clock based random value (= radius)
		translate (0.6 + 0.6 * rand(I)) * x
		
		// position to random position at radius
		rotate <rand(I)*360, rand(I)*360, rand(I)*360>
	}
	#declare cnt = cnt - 1;
	#end
}

difference {
	object {
		Base
		rotate -40 * x
		translate -0.4 * y
	}
	object {
		Holes
		pigment { rgb <0,0,0> }
	}
	// animate
	rotate clock * 360 * z
	rotate clock * 90 * y
	rotate clock * 90 * x
}
