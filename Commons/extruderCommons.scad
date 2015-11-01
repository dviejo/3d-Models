/**
 * Extruder common functions and constants
 * 
 * Created by Diego Viejo
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

trackerDiam1 = 10.56; //MK7
trackerDiam2 = 6.56;  //MK8
trackerDiam = trackerDiam2;
AjusteNozzle = 1.0; 
correction = 0.0; //(trackerDiam1 - trackerDiam) / 2;

ptfeTubeRad = 3.2;
simpleTubeRad = 1.9;
tubeRad = simpleTubeRad;

/**
 * module base. Creates the minimal piece for direct extrusion
 * 
 */

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



/*
 * E3d v6 mount dimensions +/- tolerances
 * Tolerances are set up for a .4 mm nozzle 
 */

e3dDiam = 16 + 0.6;
e3dDiam2 = 12 + 0.6;

e3dHeight1 = 3.75 + 0.35; 
e3dHeight2 = 6 - 0.45; 
e3dHeight3 = 15; 

/*
 * JHead mount dimensions +/- tolerances
 * Tolerances are set up for a .4 mm nozzle 
 */

jhDiam = 16 + 0.7;
jhDiam2 = 12 + 0.6125;

jhHeight1 = 4.8 + 0.4; 
jhHeight2 = 4.6 - 0.4; 
jhHeight3 = 15; 

//TODO Next should be set by the method who calls extruderMount.
// height1 = e3dHeight1;
// height2 = e3dHeight2;
// height3 = e3dHeight3; 
// diam = e3dDiam;
// diam2 = e3dDiam2;
height1 = jhHeight1;
height2 = jhHeight2;
height3 = jhHeight3; 
diam = jhDiam;
diam2 = jhDiam2;

/**
 * Grooved extruder mounting
 */

module extruderMount(dualExtruder=false)
{
  translate([0, 0, -height1]) hull()
  {
    cylinder(r=diam/2, h=height1);
    translate([0, -30, 0]) cylinder(r=diam/2, h=height1);
  }

  translate([0, 0, -height1-height2-height3+1]) hull()
  {
    cylinder(r=diam2/2, h=height2+ height3);
    translate([0, -30, 0]) cylinder(r=diam2/2, h=height2+ height3);
  }
  
  translate([0, 0, -height1-height2-height3]) hull() 
  {
    cylinder(r=diam/2, h=height3);
    translate([0, -30, 0]) cylinder(r=diam/2, h=height3);
  }
  
  //filament hole
  translate([0, 0, -15]) cylinder(r=tubeRad, h=50);

  if(dualExtruder==true)
  {
    //dual extruder particular
    translate([diam2/2 + 7, -20, -height1-height2/2]) rotate([-90, 0, 0]) 
      cylinder(r=1.55, h=16);
    hull()
    {
      translate([diam2/2 + 7, -diam/2, -height1-height2/2]) rotate([-90, 90, 0]) 
	cylinder(r=3.2, h=3, $fn=6);
      translate([diam2/2 + 7, -diam/2, -30]) rotate([-90, 90, 0]) 
	cylinder(r=3.2, h=3, $fn=6);
    }

    //dual extruder particular
    translate([-(diam2/2 + 7), -20, -height1-height2/2]) rotate([-90, 0, 0]) 
      cylinder(r=1.55, h=30);
    hull()
    {
      translate([-(diam2/2 + 7), -2, -height1-height2/2]) rotate([-90, 90, 0]) 
	cylinder(r=3.2, h=3, $fn=6);
      translate([-(diam2/2 + 7), -2, -30]) rotate([-90, 90, 0]) 
	cylinder(r=3.2, h=3, $fn=6);
    }
  }
  else
  {
    for(i=[-1, 1]) //general
    {
      translate([i*(diam2/2 + 7), -20, -height1-height2/2]) rotate([-90, 0, 0]) 
	cylinder(r=1.55, h=30, $fn=30);
      hull()
      {
	translate([i*(diam2/2 + 7), -2, -height1-height2/2]) rotate([-90, 90, 0]) 
	  cylinder(r=3.2, h=3, $fn=6);
	translate([i*(diam2/2 + 7), -2, -30]) rotate([-90, 90, 0]) 
	  cylinder(r=3.2, h=3, $fn=6);
      }
    }
  }
  
}

mountB_H3 = 1;
module extruderMountB() translate([0, 0, -height1-height2-mountB_H3])
{
  difference()
  {
    union()
    {
      translate([-(diam-0.4)/2, 0, 0]) cube([diam-0.4, diam/2+3, height1+height2+mountB_H3]);
      translate([-35/2, diam/2+2, 0]) cube([35, 7, height1+height2+mountB_H3]);
    }
    
    translate([0, 0, -1]) cylinder(d=diam, h=1+mountB_H3);
    translate([0, 0, -1]) cylinder(d=diam2, h=height1+height2+mountB_H3+2);
    translate([0, 0, height2+mountB_H3]) cylinder(d=diam, h=1+height1);
    
    translate([-diam2/2-10, -1, mountB_H3-0.15]) cube([10.3, diam/2+3, height2+0.3]);
    translate([diam2/2-0.3, -1, mountB_H3-0.15]) cube([10, diam/2+3, height2+0.3]);
    
    translate([-diam/2-1, -1, -1]) cube([diam+2, diam2/2+1, 1+mountB_H3]);
    translate([-diam/2-1, -1, mountB_H3+height2]) cube([diam+2, diam2/2+1, 1+height1]);
    
    for(i=[-1, 1]) 
    {
      translate([i*(diam2/2 + 7), 0, mountB_H3+height2/2]) rotate([-90, 0, 0]) 
	cylinder(r=1.55, h=diam/2+6, $fn=30);
      translate([i*(diam2/2 + 7), diam/2+6.3, mountB_H3+height2/2]) rotate([-90, 0, 0]) 
	cylinder(r=3.2, h=6);

    }
  }
  
}




//auxiliary method
module nestedHull()
{
  for(i=[0:$children-2])
    hull()
    {
      children(i);
      children(i+1);
    }
}
