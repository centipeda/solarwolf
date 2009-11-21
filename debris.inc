/*
 * Some pieces of metallic debris for the Solarwolf game.
 * Each should be able to rotate within a 1 unit cube
 *
 * (w) 2004 by Eero Tamminen
 */

#declare XMAX=1.1;
#declare XMIN=-XMAX;
#declare YMAX=1.1;
#declare YMIN=-YMAX;

#include "camera-ortho.inc"
#include "lights.inc"
#include "metals.inc"


#declare Disc =
sphere {
	0, 1
	texture { T_Brass_5B }
}

#declare Debris1 =
union {
	// a pin
	cone {
		<0, 1.4, 0>, 0.2, <0, 0, 0>, 0.6
		texture { T_Chrome_4A }
	}
	object {
		Disc
		scale <0.9, 0.3, 0.9>
	}
	// center
	translate -0.5 * y
}

#declare Cross = 
union {
	// a cross
	cylinder {
		<-1, 0, 0>, <1, 0, 0>, 0.25
	}
	cylinder {
		<0, -1, 0>, <0, 1, 0>, 0.25
	}
	texture { T_Copper_5B }
}

#declare Debris2 =
union {
	// a star cross
	object { Cross }
	cylinder {
		<0, 0, -1>, <0, 0, 1>, 0.3
		texture { T_Chrome_3C }
	}
}

#declare Debris3 =
difference {
	cylinder {
		// disc
		<0, 0, -0.3>, <0, 0, 0.3>, 1
		texture { T_Chrome_4A }
	}
	object {
		// groove
		Cross
		translate -0.3 * z
	}
	object {
		// another groove + hole
		Debris2
		translate 0.3 * z
	}
}

#declare Debris4 =
difference {
	// cube with indentations
	box {
		<-1, -1, -1>, <1, 1, 1>
		texture { T_Silver_3C }
	}
	object {
		Disc
		scale 0.2 * x
		translate x
	}
	object {
		Disc
		scale 0.2 * x
		translate -x
	}
	object {
		Disc
		scale 0.2 * y
		translate y
	}
	object {
		Disc
		scale 0.2 * y
		translate -y
	}
	object {
		Disc
		scale 0.2 * z
		translate z
	}
	object {
		Disc
		scale 0.2 * z
		translate -z
	}
	scale 0.7
}
