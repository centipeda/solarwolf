#include "debris.inc"
object {
	Debris2

	// random orientation
	#declare I = seed(431);
	rotate <rand(I)*360, rand(I)*360, rand(I)*360>

	// animate
	rotate clock * 90 * x
	rotate clock * 180 * y
	rotate clock * 270 * z
}
