/**
 * Martir.scad
 * 
 * Created by DViejo
 * 24 Nov 2014
 * 
 * Template for drilling M4 holes in i3 Y-plate for allocating a sc8uu bearing
 * 
 */

moebyus = 31/2;
standard = 10;
 
sideDist = standard;

shift = 0; //0 for standard, 6 for moebyus

module martir()
{
  difference()
  {
    union()
    {
      translate([-18, -18, 0]) cube([36+shift/3, 36, 4]);
      hull()
      {
	translate([-12.5, 0, 0]) cylinder(r=4.775, h=5.5, $fn=20);
	translate([12.5, 0, 0]) cylinder(r=4.775, h=5.5, $fn=20);
      }
    }
    
    for(i = [-1, 1])
    {
      translate([0, sideDist*i, -1]) cylinder(r=1.65, h=10);
      for(j = [-1, 1])
	#translate([9*i+shift, 12*j, -1]) cylinder(r=2.15, h=10, $fn=20);
    }
  }
}

martir();