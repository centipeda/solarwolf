# generates suitable explosion file for POV

from random import seed, random

seed(29)
max = 32
count = max

while count > 0:
    print 'sphere {'
    print '	0, (0.8 * clock - 0.4) +', count / max
    print '	translate y * (1.4 + clock/2 - %g)' % (count / max)
    
    x = (max - count) / max
    y = count / max
    z = random()

    rnd = random()
    if rnd < 0.17:
	x,y,z = x,y,z
    if rnd < 0.34:
	x,y,z = y,x,z
    if rnd < 0.50:
	x,y,z = y,z,x
    if rnd < 0.66:
	x,y,z = x,z,y
    if rnd < 0.83:
	x,y,z = z,x,y
    else:
	x,y,z = z,y,x
    
    print '	rotate <%g, %g, %g>' % (360*x, 360*y, 360*z)
    print '}'
    count -= 1.0
