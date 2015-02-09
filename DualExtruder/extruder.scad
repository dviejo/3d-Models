/**
 * Compact dual extruder 
 * Derived from the direct extruder idea from Whosa whatsis
 * Created by DViejo
 * Version V1.0
 * Status: development
 */

include<config.scad>
//include<XCarriageDual.scad>

module base(action) translate([-trackerDiam/2 - AjusteNozzle, 15.5*2+5, -baseHeight - mainHeight/2-offset])
{
	if(action == "add") {
		union() {
			translate([-15.5, 0, 0]) rotate(120) {
				translate([0, -5, 0]) cube([8, 10, baseHeight*2 + mainHeight]);
				translate([8, 0, 0]) cylinder(r=5, h=baseHeight*2 + mainHeight);
				translate([13, 0, 0]) rotate(-150 - 9 / 2) cube([15+5, 5+5, baseHeight*2 + mainHeight]);
			}
			hull()
			{
			  for (side = [1, -1]) translate([side * 15.5, 0, 0]) cylinder(r=5, h=baseHeight*2 + mainHeight);
			  for (side = [1, -1]) translate([side * 15.5, -15.5*2, 0]) cylinder(r=5, h=baseHeight*2 + mainHeight);
			}
		}
	} else //remove
	{
		//motor mounting holes
		//up
		for (side = [1, -1]) translate([side * 15.5, 0, -1]) cylinder(r = 3.1 * 7/12, $fn = 6, h=baseHeight*2 + mainHeight+2);
		//bottom with room for bolt cap
		for (side = [1, -1]) 
		{
		  translate([side * 15.5, -31, 8]) cylinder(r=3.1 * 7/12, h=mainHeight+baseHeight+12);
		  translate([side * 15.5, -31, -1]) cylinder(r=3.2, h=8.7);
		}
		
		translate([0, -15.5, baseHeight*2 + mainHeight-7]) cylinder(r=12, h=10);
		translate([0, -15.5, -1]) cylinder(r=3.25, h=baseHeight*2 + mainHeight+2); //TODO This can be replaced by holder for a 625zz bearing
		
		//idler cut-out
		difference()
		{
		  union()
		  {
		    translate([-15.5, 0, -1]) rotate(30) translate([0, 5+correction*2, 0]) rotate(-60 - 9 / 2) translate([-15, 5, 0]) cube([50, 20, mainHeight + baseHeight*2+2]);
		    translate([-7, -6, -1]) cube([30, 40, mainHeight + baseHeight*2+2]);
		  }
		  translate([-10, -20, -2]) cube([100, 25, baseHeight+2]);
		}
		//Springs
		#translate([-15.5, 0, baseHeight + mainHeight / 2+offset+3]) rotate([90, 0, 150 - 4.5]) translate([5, 0, 5.5+correction*1.25]) 
		  cylinder(r = spring_d * 7/12, h = 10, $fn = 6);
		#translate([-15.5, 0, baseHeight + mainHeight / 2+offset-9]) rotate([90, 0, 150 - 4.5]) translate([5, 0, 5.5+correction*1.25]) 
		  cylinder(r = spring_d * 7/12, h = 10, $fn = 6);
		//hole for filament intake
		translate([trackerDiam/2 + AjusteNozzle, -60, baseHeight + mainHeight/2+offset]) rotate([-90, 0, 0]) cylinder(r=1.85, h=100, $fn = 25);
		translate([trackerDiam/2 + AjusteNozzle-5, -15.5, baseHeight + mainHeight/2+offset+5]) rotate([-90, 0, 0]) cube([10, 15, 10]);

		//internal room. The structure for guiding filament is here!
		translate([-21, -26, baseHeight]) cube([21, 20, mainHeight+baseHeight+1]);
		translate([7, -26, baseHeight]) cube([14.1, 20, mainHeight+baseHeight+1]);		//Idler hole
		translate([trackerDiam + AjusteNozzle+filament_d, -15.5, baseHeight]) cylinder(r=bearingRad*1.25, h=22);
		translate([0, -15.5, baseHeight]) cylinder(r=(trackerDiam/2)*1.30, h=22);
		
		%translate([0, -15.5, baseHeight + mainHeight/2+offset+7.7]) mirror([0, 0, 1]) tracker();

	}
}


module tracker()
{
    //%translate([0, 0, 8.25]) 
    difference() {
	linear_extrude(height = 11, convexity = 5) difference() {
		circle(trackerDiam/2);
		circle(2.5);
	}
	translate([0, 0, 7.7]) rotate_extrude(convexity = 5, $fs = 0.5) translate([trackerDiam/2 + 1.3, 0, 0]) circle(r = 2);
  }

}

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

