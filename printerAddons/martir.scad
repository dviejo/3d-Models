/**
 * Martir.scad
 * 
 * Created by DViejo
 * 24 Nov 2014
 * 
 * Template for drilling M4 holes in i3 Y-plate for allocating a sc8uu bearing
 * 
 */

module martir()
{
  difference()
  {
    union()
    {
      translate([-16, -14, 0]) cube([32, 28, 4]);
      hull()
      {
	translate([-8, 0, 0]) cylinder(r=3.5, h=5.5, $fn=20);
	translate([8, 0, 0]) cylinder(r=3.5, h=5.5, $fn=20);
      }
    }
    
    for(i = [-1, 1])
    {
      translate([0, 8*i, -1]) cylinder(r=1.65, h=10);
      for(j = [-1, 1])
	#translate([12*i, 9*j, -1]) cylinder(r=2, h=10, $fn=20);
    }
  }
}

martir();