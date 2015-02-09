/**
 * DViejosCompactExtruder
 * 
 * created by Diego Viejo
 * 
 */


filament_d = 3;
spring_d = 10;

mainHeight = 14;
baseHeight = 6; 
offset = 3;

b623zzRad = 5;
b624zzRad = 6.5;
b623zzHeight = 4;
b624zzHeight = 5;

bearingRad = b623zzRad;
bearingHeight = b623zzHeight;

trackerDiam1 = 10.56;
trackerDiam2 = 6.56;
trackerDiam = trackerDiam2;
AjusteNozzle = 1.25;
correction = (trackerDiam1 - trackerDiam) / 2;


ptfeTubeRad = 3.2;
simpleTubeRad = 1.9;
tubeRad = simpleTubeRad;

carriagePos = -17.5;


//auxiliary
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


e3dDiam = 16 + 0.75;
e3dDiam2 = 12 + 0.65;

e3dHeight1 = 3.75 + 0.4; 
e3dHeight2 = 6 - 0.4; 
e3dHeight3 = 15; 

module e3dMount()
{
  translate([0, 0, -e3dHeight1]) hull()
  {
    cylinder(r=e3dDiam/2, h=e3dHeight1);
    translate([0, -30, 0]) cylinder(r=e3dDiam/2, h=e3dHeight1);
  }

  translate([0, 0, -e3dHeight1-e3dHeight2-e3dHeight3+1]) hull()
  {
    cylinder(r=e3dDiam2/2, h=e3dHeight2+ e3dHeight3);
    translate([0, -30, 0]) cylinder(r=e3dDiam2/2, h=e3dHeight2+ e3dHeight3);
  }
  
  translate([0, 0, -e3dHeight1-e3dHeight2-e3dHeight3]) hull() 
  {
    cylinder(r=e3dDiam/2, h=e3dHeight3);
    translate([0, -30, 0]) cylinder(r=e3dDiam/2, h=e3dHeight3);
  }
  
  #translate([25, -e3dHeight2-1.25, -e3dHeight1-1.5]) rotate([0, -90, 0]) cylinder(r=1.55, h=50);
}


module base() translate([-trackerDiam/2 - AjusteNozzle, 15.5+5, -baseHeight - mainHeight/2-offset])
{
	difference() {
		union() {
			translate([-15.5, 0, 0]) rotate(120) {
				translate([0, -5, 0]) cube([8, 10, baseHeight*2 + mainHeight]);
				translate([8, 0, 0]) cylinder(r=5, h=baseHeight*2 + mainHeight);
				translate([13, 0, 0]) rotate(-150 - 9 / 2) cube([15+5, 5+5, baseHeight*2 + mainHeight]);
			}
			hull()
			{
			  for (side = [1, -1]) translate([side * 15.5, 0, 0]) cylinder(r=5, h=baseHeight*2 + mainHeight);
			  for (side = [1, -1]) translate([side * 15.5, -42, 0]) cylinder(r=5, h=baseHeight*2 + mainHeight);
			}
		}
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
		    translate([-15.5, 0, -1]) rotate(30) translate([0, 5+correction*2, 0]) rotate(-60 - 9 / 2) translate([-15, 5, 0]) cube([60, 50, mainHeight + baseHeight*2+2]);
		    translate([-7, -6, -1]) cube([100, 100, mainHeight + baseHeight*2+2]);
		  }
		  translate([-10, -20, -2]) cube([100, 25, baseHeight+2]);
		}
		//Springs
		#translate([-15.5, 0, baseHeight + mainHeight / 2+offset+3]) rotate([90, 0, 150 - 4.5]) translate([5, 0, 5.5+correction*1.25]) 
		  cylinder(r = spring_d * 7/12, h = 10, $fn = 6);
		#translate([-15.5, 0, baseHeight + mainHeight / 2+offset-9]) rotate([90, 0, 150 - 4.5]) translate([5, 0, 5.5+correction*1.25]) 
		  cylinder(r = spring_d * 7/12, h = 10, $fn = 6);
		//hole for filament intake
		translate([trackerDiam/2 + AjusteNozzle, -15.5-50, baseHeight + mainHeight/2+offset]) rotate([-90, 0, 0]) cylinder(r=tubeRad, h=100, $fn = 25); //r=1.85

		//internal room. The structure for guiding filament is here!
		translate([-21, -26, baseHeight]) cube([21, 20, mainHeight+baseHeight+1]);
		translate([8, -26, baseHeight]) cube([13, 20, mainHeight+baseHeight+1]);
		translate([-21, -26, baseHeight*2 + mainHeight-8]) cube([40, 20, mainHeight+baseHeight+1]);
		//Idler hole
		translate([trackerDiam + AjusteNozzle+filament_d, -15.5, baseHeight]) cylinder(r=bearingRad*1.25, h=22);
		translate([0, -15.5, baseHeight]) cylinder(r=(trackerDiam/2)*1.30, h=22);
		
		%translate([0, -15.5, baseHeight + mainHeight/2+offset+7.7]) mirror([0, 0, 1]) tracker();

	}
}

module DViejosCompactExtruder()
{
  difference()
  {
    base();
    translate([0, -16.75, 0]) rotate([-90, 0, 0]) e3dMount();
    
    //xcarriage holes for PowerCode/Hephestos XCarriage
    for(i=[-1, 1])
    {
      #translate([i*15-2, carriagePos, -25]) cylinder(r=1.65, h=50);
      translate([i*15-2, carriagePos, baseHeight - mainHeight/2 - offset]) cylinder(r=3.3, h=50);
    }
  }
}

DViejosCompactExtruder();
