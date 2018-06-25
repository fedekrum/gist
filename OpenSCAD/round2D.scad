// round2D() will round the edges of a 2D child shape.

module round2D(x=2,fn=10)
{
    offset(r=-x,$fn=fn)
    offset(r=x*2,$fn=fn)
    offset(r=-x,$fn=fn)
    children();
}

// eg.

module shape()
    difference() {
        square(40, center = true);
        square(20, center = true);
    }

color("red")
round2D(2,10)
shape();

// Here are examples to round inner, outer or both

$fn = 32;

color("red")
    offset(3) offset(-3) shape();

color("blue")
translate([50, 0, 0])
    offset(-3) offset(3) shape();

color("green")
translate([100, 0, 0])
    offset(-3) offset(3*2) offset(-3) shape();
