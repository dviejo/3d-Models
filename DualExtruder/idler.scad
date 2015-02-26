/*
 * Idler.scad
 * 
 * Idler part for uterus extruder
 * Based on the original idea from Whosa whatsis
 * Created by Diego Viejo
 */


include<config.scad>

idlerHeight = mainHeight + 2* baseHeight - 1;

fineTunning = 1.15;

module support(h=5, r=5, n=1)
{
  for(i = [1:n])
  {
    translate([2*r*(i-1), 0, 0])
    {
      difference()
      {
	cylinder(r=r, h=h);
	translate([0, 0, -1]) cylinder(r=r-0.4, h=2+h);
      }
    }
  }
}


module idler()
{
  difference()
  {
    union()
    {
      cylinder(r=5, h=idlerHeight);
      translate([0, -15+correction, 0]) cylinder(r=5, h=idlerHeight);
      translate([-5, -15+correction, 0]) cube([10, 15.5+correction, idlerHeight]);

      rotate(-60) nestedHull()
      {
	translate([-6.5, 0, 0]) cube([6.5, 37, idlerHeight]);
	translate([-2.5, 37, 0]) rotate(30)
		translate([-2.5, 0, 0]) cube([5, 4, idlerHeight]);
	translate([-2.5, 37, 0]) rotate(30)
		translate([0, 7, 0]) cylinder(r = 2.5, h = idlerHeight);
      }
      rotate(-30) translate([0, 0, 0]) cube([5, 10, idlerHeight]);
      cylinder(r=bearingRad+1.5, h=idlerHeight);
      
    }
    
    //clearance for the extruder structure
    translate([-50, -93, mainHeight + baseHeight - 1]) cube([100, 100, 100]);
    
    //idler attaching hole
    rotate(-9) translate([15.5 - 10 - filament_d+2.5, -15.5 + fineTunning, 0])
    {
      translate([0, 0, 5.3])
	cylinder(r = 2.5/2, h = 2);
      translate([0, 0, mainHeight/2 + offset + 2.25+0.35])
	cylinder(r = 3.2/2, h = 10);
      translate([0, 0, mainHeight/2 + offset + 4.5])
	cylinder(r = 3.2, h = 10);
      // idler bearing, for viewing
      %translate([0, 0, mainHeight/2 + offset -4.7/2])
	cylinder(r = 5, h = 4);
    }
    
    translate([0, 0, mainHeight/2 + offset]) {
	//idler bearing main hole
	translate ([0, 0, 0]) rotate(-9) 
	  translate([15.5 - 10 - filament_d+2.5, -15.5+ fineTunning, -6.25/2]) //-5.5/2
	    cylinder(r = 6.5, h = 5.4);
	//filament through hole
	hull()
	{
	  translate([12, 21, -1]) 
		rotate([90, 0, -6]) 
		  cylinder(r = tubeRad+1, h = 27);
	  translate([-3, -2, -1]) 
		rotate([90, 0, -12]) translate([15, 0, -15.5]) 
		  cylinder(r = tubeRad+1, h = 20, center = true);
	}
    }
          
      //spring holes
      #translate([0, 0, idlerHeight / 2 + offset + 3]) rotate([90, 0, 30]) translate([31, 0, -2]) cylinder(r = spring_d * 7/12, h = 13, $fn = 6);
      #translate([0, 0, idlerHeight / 2 + offset - 9]) rotate([90, 0, 30]) translate([31, 0, -2]) cylinder(r = spring_d * 7/12, h = 13, $fn = 6);
      
      //bearing holes
      translate([0, 0, -0.15]) cylinder(r=bearingRad+0.18, h=bearingHeight+0.3, $fn=30);
      translate([0, 0, baseHeight+mainHeight - 1 - bearingHeight])
	cylinder(r=bearingRad+0.18, h=bearingHeight+0.3, $fn=30);
      
      //main screew hole
      translate([0, 0, bearingHeight+0.5]) cylinder(r=3, h=40, $fn=15);
      
      //clearance for motor's frontal
      difference()
      {
	hull()
	{
	  translate([0, -15.5, -1]) cylinder(r=5.25, h=5);
	  translate([-5.25, -11, -1]) cube([5.25*2, 5.25*2, 5]);
	}
	translate([0, 0, -1]) cylinder(r=bearingRad+1.5, h=10);
      }

  }
  //support
  translate([0, -15+correction, 0]) support(h=5);
  difference()
  {
    translate([0, -15+correction, 6.75]) support(h=5.7);
    translate([-10, -15+correction, 6.65]) cube([20, 5, 5.8]);
  }
  
}

idler();
mirror([1, 0, 0]) 
  translate([-30, -20, 0]) rotate(90)
    idler();
