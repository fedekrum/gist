// round2D() will round the edges of a 2D child shape.

module round2Dboth(x=2,fn=10)
{
    offset(r=-x,$fn=fn)
    offset(r=x*2,$fn=fn)
    offset(r=-x,$fn=fn)
    children();
}

module round2Dinner(x=2,fn=10)
{
    offset(r=-x,$fn=fn)
    offset(r=x,$fn=fn)
    children();
}

module round2Douter(x=2,fn=10)
{
    offset(r=x,$fn=fn)
    offset(r=-x,$fn=fn)
    children();
}

// A 2D shape to make a working example
module shape()
    difference() {
        square(40, center = true);
        square(20, center = true);
    }

// Here are examples to round inner, outer or both
// BECAREFUL WITH THE VALUES

color("red")
    round2Dinner(3,30) shape();

color("blue")
translate([50, 0, 0])
    round2Douter(3,30) shape();

color("green")
translate([100, 0, 0])
    round2Dboth(3,30) shape();
