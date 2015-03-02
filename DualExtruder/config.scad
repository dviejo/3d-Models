

//separation between nozzles
headDist = 15.5*2+5;

// Next 4 lines are not used anymore. Delete them 
simple = 0;
prusaNozzle = 1; //for prusaNozzle and Budas
jHead = 2; //jor jHead 
E3D = 3;

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

mountingHoleSep = 32;

/*
 * E3d v6 mount dimensions +/- tolerances
 * Tolerances are set up for a .4 mm nozzle 
 */

e3dDiam = 16 + 0.7;
e3dDiam2 = 12 + 0.625;

e3dHeight1 = 3.75 + 0.4; 
e3dHeight2 = 6 - 0.4; 
e3dHeight3 = 15; 

/*
 * JHead mount dimensions +/- tolerances
 * Tolerances are set up for a .4 mm nozzle 
 */

jhDiam = 16 + 0.7;
jhDiam2 = 12 + 0.625;

jhHeight1 = 3.75 + 0.4; 
jhHeight2 = 6 - 0.4; 
jhHeight3 = 15; 


/**
 * Grooved extruder mounting
 */

module extruderMount(height1 = e3dHeight1, height2 = e3dHeight2, height3 = e3dHeight3, diam = e3dDiam, diam2 = e3dDiam2)
{
  translate([0, 0, -e3dHeight1]) hull()
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

  *for(i=[-1, 1]) //general
  {
    translate([i*(diam2/2 + 7), -20, -height1-height2/2]) rotate([-90, 0, 0]) 
      cylinder(r=1.55, h=30);
    hull()
    {
      translate([i*(diam2/2 + 7), -2, -height1-height2/2]) rotate([-90, 90, 0]) 
	cylinder(r=3.2, h=3, $fn=6);
      #translate([i*(diam2/2 + 7), -2, -30]) rotate([-90, 90, 0]) 
	cylinder(r=3.2, h=3, $fn=6);
    }
  }
  
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

mountB_H3 = 1;
module e3dMountB() translate([0, 0, -e3dHeight1-e3dHeight2-mountB_H3])
{
  difference()
  {
    union()
    {
      translate([-(e3dDiam-0.4)/2, 0, 0]) cube([e3dDiam-0.4, e3dDiam/2+3, e3dHeight1+e3dHeight2+mountB_H3]);
      translate([-35/2, e3dDiam/2+2, 0]) cube([35, 7, e3dHeight1+e3dHeight2+mountB_H3]);
    }
    
    translate([0, 0, -1]) cylinder(d=e3dDiam, h=1+mountB_H3);
    translate([0, 0, -1]) cylinder(d=e3dDiam2, h=e3dHeight1+e3dHeight2+mountB_H3+2);
    translate([0, 0, e3dHeight2+mountB_H3]) cylinder(d=e3dDiam, h=1+e3dHeight1);
    
    translate([-e3dDiam2/2-10, -1, mountB_H3-0.15]) cube([10.3, e3dDiam/2+3, e3dHeight2+0.3]);
    translate([e3dDiam2/2-0.3, -1, mountB_H3-0.15]) cube([10, e3dDiam/2+3, e3dHeight2+0.3]);
    
    translate([-e3dDiam/2-1, -1, -1]) cube([e3dDiam+2, e3dDiam2/2+1, 1+mountB_H3]);
    translate([-e3dDiam/2-1, -1, mountB_H3+e3dHeight2]) cube([e3dDiam+2, e3dDiam2/2+1, 1+e3dHeight1]);
    
    for(i=[-1, 1]) 
    {
      translate([i*(e3dDiam2/2 + 7), 0, mountB_H3+e3dHeight2/2]) rotate([-90, 0, 0]) 
	cylinder(r=1.55, h=e3dDiam/2+6);
      translate([i*(e3dDiam2/2 + 7), e3dDiam/2+6.3, mountB_H3+e3dHeight2/2]) rotate([-90, 0, 0]) 
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
