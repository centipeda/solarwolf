/*
 * A space ship for the Solarwolf game
 *
 * (w) 2003 by Eero Tamminen
 */

#declare ShipFinish =
finish {
	brilliance 1
	phong 4
	phong_size 60
	reflection 0.1
}


#declare Base =
difference {
	union {
		sphere {
			0, 1
		}
		// red "glass" band
		difference {
			intersection {
				sphere {
					<0, 1.3, 0>, 1
					scale <1, 1, 2.4>
				}
				sphere {
					0, 1.02
				}
			}
			sphere {
				<0, 1.55, 0.2>, 1
				scale <1, 1, 2.2>
			}
			sphere {
				0, 0.98
			}
			pigment { rgb <1, 0, 0> }
			finish { ShipFinish }
		}
	}
	intersection {
		sphere {
			0, 1
			scale <0.5, 2, 1>
		}
		sphere {
			<0, 1.3, 0>, 1.2
			scale <1, 1, 2>
		}
		pigment { rgb <0.5, 0.6, 1> }
	}
	sphere {
		<0, 0, -1.5>, 1.5
		scale <1, 3, 0.5>
	}
	scale <1, 0.3, 2>

	// light yellow gray
	pigment { rgb <0.8, 0.8, 0.7> }
	finish { ShipFinish }
}


#declare BubbleColor = color rgb <0.6, 0.9, 1>;

#declare BubbleFinish =
finish {
	metallic
	brilliance 5
	phong 2
	phong_size 40
	reflection 0.5
}

#declare Bubble =
sphere {
	0, 1
	scale <1, 0.6, 1>
}


#ifdef (ShipThrust)
#declare Thrust =
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
#if (ShipThrust > 1)
					[ 0.1 color rgbt <1, 0.5, 0.5, 0.5> ]
					[ 0.4 color rgb  <2, 1, 0.5> ]
					[ 0.7 color rgb  <2, 1, 0> ]
					[ 1.0 color rgb  <2, 2, 1> ]
#else
					[ 0.1 color rgbt <0, 0, 0.8, 0.5> ]
					[ 0.2 color rgb  <0, 0, 1> ]
					[ 0.4 color rgb  <0, 1, 2> ]
					[ 0.6 color rgb  <0, 2, 2> ]
					[ 1.0 color rgb  <1.5, 1.5, 1.5> ]
#end
				}
				turbulence 0.3
			}
			scale 0.5
		}
	}
	hollow
#if (ShipThrust > 1)
	scale <0.9, 0.9, 1.2>
	translate -0.2 * z
#else
	scale <0.8, 0.8, 0.8>
#end
}
#end


#declare MotorColor = color rgb <0.7, 0.2, 0.2>;

#declare MotorFinish =
finish { ShipFinish }

#declare Motor =
difference {
	cone {
		<0, 0, 1.6>, 0.4, <0, 0, 0>, 0.9
	}
	sphere {
		0, 0.8
	}
	scale 0.3
}


#declare Ship =
union {
	object {
		Base
	}
	// bluegreen bubbles (from back to front)
	union {
		object {
			Bubble
			scale 0.45
			translate <0, 0, 0.5>
		}
		object {
			Bubble
			scale 0.35
			translate <0, 0, 1.3>
		}
		pigment { BubbleColor }
		finish { BubbleFinish }
	}
	union {
		object {
			Motor
			translate <0.4, 0, -0.4>
		}
		object {
			Motor
			translate <-0.4, 0, -0.4>
		}
		pigment { MotorColor }
		finish { MotorFinish }
	}
#ifdef (ShipThrust)
	object {
		Thrust
		rotate 360 * clock * z
		translate <-0.4, 0, -0.55>
	}
	object {
		Thrust
		rotate -360 * clock * z
		translate <0.4, 0, -0.55>
	}
#end
	translate -0.2 * y
}
