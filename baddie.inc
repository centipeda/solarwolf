/* 
 * An enemy for solarwolf game
 *
 * (w) 2003 by Eero Tamminen
 */

#declare Head =
union {
	cone {
		<0, 0, 0>, 1.5, <0, 6.5, 0>, 0.2
	}
	sphere {
		0, 1.5
	}
	translate -0.2 * y
}

#declare Arm =
intersection {
	box {
		<0, -1.2, -1.2>, <6, 1.2, 1.2>
	}
	cylinder {
		<0, 0, 0>, <6, 0, 0>, 1.3
	}
}

#declare Trunk =
difference {
	intersection {
		cylinder {
			<-2.2, 0, 0>, <2.2, 0, 0>, 1.8
		}
		sphere {
			0, 2.5
		}
	}
	union {
		sphere {
			<0, 0, -1.8>, 0.4
		}
		sphere {
			<0, 0, 1.8>, 0.4
		}
#if (clock >= 0.9)
		pigment { rgb <0, 2, 0> }
#else
#if (clock > 0.2)
		pigment { rgb <2, 0, 0> }
#else
		pigment { rgb <2, 2, 0> }
#end
#end
	}
	union {
		torus {
			1.8, 0.2
			rotate 90 * z
			translate -x
		}
		torus {
			1.8, 0.2
			rotate 90 * z
			translate x
		}
		pigment { rgb <2, 2, 0> }
	}
}

#declare BaddieTexture =
texture {
	pigment { rgb <1,1,1> }
	finish {
		brilliance 1
		phong 4
		phong_size 60
		reflection 0.1
	}
}
