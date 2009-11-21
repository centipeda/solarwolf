/*
 * Some bonus images for the Solarwolf game.
 *
 * With "Shield" bonus the shield diminishing is animated,
 * with "Bullet" shield there's animation while the bonus is on.
 * 
 * (w) 2004 by Eero Tamminen
 */

#declare XMAX=1;
#declare XMIN=-XMAX;
#declare YMAX=1;
#declare YMIN=-YMAX;

#include "camera-ortho.inc"
#include "lights.inc"


#declare BonusShield =
torus {
	0.85, 0.1 - clock * 0.08
	#declare ShieldBad = <2, 0, 0>;
	#declare ShieldGood = <0, 1.2, 0>;
	#declare ShieldChange = ShieldBad - ShieldGood;
	pigment {
		color rgb ShieldGood + clock * ShieldChange
	}
	rotate 90 * x
}


#declare Bullet =
union {
	sphere {
		0, 0.1
	}
	cone {
		<0, 0, 0>, 0.1, <0.4, 0, 0>, 0
	}
}

#declare Bullets = 6;

#declare BonusBullet =
union {
	#declare turn = 0;
	#while (turn < 360)
		object {
			Bullet
			translate 0.85 * y
			rotate turn * z
		}
		#declare turn = turn + 360 / Bullets;
	#end
	pigment {
		color rgb <1.2, 1.2, 0>
	}
}
