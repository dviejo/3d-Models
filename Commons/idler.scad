/*
 * Idler.scad
 * 
 * Idler part for direct extruders like Dual extruder, compact extruder or uterus.
 * Based on the direct extruder from Whosa whatsis
 * Created by Diego Viejo
 */


include<extruderCommons.scad>

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
      //cylinder(r=5, h=idlerHeight);
      translate([0, -15+correction, 0]) cylinder(r=5, h=idlerHeight);
      translate([-5, -15+correction, 0]) cube([10, 15.5+correction, idlerHeight]);

      rotate(-60) 
      nestedHull()
      {
        cylinder(r=bearingRad+1.5, h=idlerHeight);
	translate([-(bearingRad+1.5), 0, 0]) cube([bearingRad+1.5, bearingRad+1.5+2, idlerHeight]);
	translate([-(bearingRad+1.5)/2, 37, 0]) cylinder(d=bearingRad+1.5, h=idlerHeight);
      }
      *rotate(-30) translate([0, 0, 0]) cube([5, 10, idlerHeight]);
      
    }
    
    //clearance for the extruder structure
    translate([-50, -93, mainHeight + baseHeight - 1]) cube([100, 100, 100]);
    
    //idler attaching hole
    rotate(-9) translate([15.5 - 10 - filament_d+2.5, -15.5 + fineTunning, 0])
    {
      translate([0, 0, (baseHeight+mainHeight/2+offset)-6 + 0.35])
	cylinder(r = 2.5/2, h = 3.5);
      translate([0, 0, (baseHeight+mainHeight/2+offset) + 0.5 +5.4/2 +0.35])
	cylinder(r = 3.2/2, h = 10, $fn=20);
      translate([0, 0, baseHeight+mainHeight-1 -3])
	cylinder(r2 = 3.5, r1 = 3.2/2, h = 3.1, $fn=20);
      *translate([0, 0, (baseHeight+mainHeight/2+offset) + 0.5 + 4.5])
	cylinder(r = 3.3, h = 10);
      // idler bearing, for viewing
      *%translate([0, 0, (baseHeight+mainHeight/2+offset) + 0.5 -4.7/2])
	cylinder(r = 5, h = 4);
    }
    
    translate([0, 0, (baseHeight+mainHeight/2+offset) + 0.5]) {
	//idler bearing main hole
	translate ([0, 0, 0]) rotate(-9) 
	  translate([15.5 - 10 - filament_d+2.5, -15.5+ fineTunning, -5.4/2]) //-5.5/2
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
      #translate([0, 0, (baseHeight+mainHeight/2+offset)+1.5+spring_d/2 + 0.5]) rotate([90, 0, 30]) translate([31, 0, -2]) cylinder(r = spring_d * 7/12, h = 13, $fn = 6);
      #translate([0, 0, (baseHeight+mainHeight/2+offset)-1.5-spring_d/2 + 0.5]) rotate([90, 0, 30]) translate([31, 0, -2]) cylinder(r = spring_d * 7/12, h = 13, $fn = 6);
      
      //bearing holes
      translate([0, 0, -0.15]) cylinder(r=bearingRad+0.2, h=bearingHeight+0.3, $fn=30);
      translate([0, 0, baseHeight+mainHeight - 1 - bearingHeight])
	cylinder(r=bearingRad+0.2, h=bearingHeight+0.4, $fn=30);
      
      //main screew hole
      translate([0, 0, bearingHeight+0.35+0.15]) cylinder(r=3.5, h=40, $fn=15);
      
      //clearance for motor's frontal
      difference()
      {
	hull()
	{
	  translate([0, -15.5, -1]) cylinder(r=5.25, h=(baseHeight+mainHeight/2+offset)-6);
	  translate([-5.25, -11, -1]) cube([5.25*2, 5.25*2, (baseHeight+mainHeight/2+offset)-6]);
	}
	translate([0, 0, -1.1]) cylinder(r=bearingRad+1.5, h=10);
      }

  }
  //support
  translate([0, -15+correction, 0]) support(h=(baseHeight+mainHeight/2+offset)-6);
  difference()
  {
    translate([0, -15+correction, (baseHeight+mainHeight/2+offset) + 0.5 - 5.5/2]) support(h=5.7);
    translate([-10, -15+correction, (baseHeight+mainHeight/2+offset) + 0.5 - 5.7/2]) cube([20, 5, 6]);
  }
  
}

//idler();
//Uncoment next line to get the second idler for a dual extruder
//mirror([1, 0, 0]) translate([-30, -20, 0]) rotate(90) idler();
