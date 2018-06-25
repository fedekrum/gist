// round2D( will round the edges of a 2D shape 

module round2D(x=2,fn=10)
{
    offset(r=-x,$fn=fn)
    offset(r=x*2,$fn=fn)
    offset(r=-x,$fn=fn)
    children();
}


// eg.

module shape(){
intersection()
    {
        union()
        {
            square([9,40],center=true);
            square([40,9],center=true);
            circle(d=29,$fn=360);
        }
        circle(d=37,$fn=360);
    }
}

color("red")
round2D(2,10)
shape();



linear_extrude(height = 10)
color("white",0.2)
#shape();
