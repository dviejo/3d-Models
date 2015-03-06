/**
 * Compact dual extruder 
 * Derived from the direct extruder idea from Whosa whatsis
 * Created by DViejo
 * Version V1.0
 * Status: development
 */

include<../Commons/extruderCommons.scad>
include<config.scad>
//include<XCarriageDual.scad>


module dualExtruder()
difference() {
  union()
  {
    translate([-headDist/2, 0, 0])
      base("add");
    translate([headDist/2, 0, 0]) mirror([1, 0, 0])
      base("add");
      
    translate([-25.5, 0, -baseHeight - mainHeight/2-offset]) cube([41, 41, baseHeight]);
    hull()
    {
      translate([-10, 5, -baseHeight - mainHeight/2-offset]) cylinder(r=5, h=baseHeight*2 + mainHeight);
      translate([10, 5, -baseHeight - mainHeight/2-offset]) cylinder(r=5, h=baseHeight*2 + mainHeight);
    }
  }
  translate([-headDist/2, 0, 0])
    base("remove");
  translate([headDist/2, 0, 0]) mirror([1, 0, 0])
    base("remove");
    
  for(i=[-1, 1])
  {
    translate([i*mountingHoleSep, -1.5, 0]) rotate([-90, 0, 0]) cylinder(r=2.1, h=20);
    translate([i*mountingHoleSep, 7, 0]) rotate([-90, 0, 0]) cylinder(r=4, h=10, $fn=6);
  }

}

dualExtruder();

