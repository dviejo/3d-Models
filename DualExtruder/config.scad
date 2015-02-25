

//separation between nozzles
headDist = 15.5*2+5;


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

trackerDiam1 = 10.56;
trackerDiam2 = 6.56;
trackerDiam = trackerDiam2;
AjusteNozzle = 1.0; //1.25;
correction = 0.0; //(trackerDiam1 - trackerDiam) / 2;

PTFE = false;
ptfeTubeRad = 3.2;
simpleTubeRad = 1.9;
tubeRad = simpleTubeRad;
outputAngle = 30; //35; 
curvatura = 95; //122.5;
longStright = 10;

mountingHoleSep = 32;


e3dDiam = 16 + 0.7;
e3dDiam2 = 12 + 0.625;

e3dHeight1 = 3.75 + 0.4; 
e3dHeight2 = 6 - 0.4; 
e3dHeight3 = 15; 

module e3dMount(mirror=false)
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
  
  //filament hole
  translate([0, 0, -15]) cylinder(r=1.85, h=50);

  *for(i=[-1, 1]) //general
  {
    translate([i*(e3dDiam2/2 + 7), -20, -e3dHeight1-e3dHeight2/2]) rotate([-90, 0, 0]) 
      cylinder(r=1.55, h=30);
    hull()
    {
      translate([i*(e3dDiam2/2 + 7), -2, -e3dHeight1-e3dHeight2/2]) rotate([-90, 90, 0]) 
	cylinder(r=3.2, h=3, $fn=6);
      #translate([i*(e3dDiam2/2 + 7), -2, -30]) rotate([-90, 90, 0]) 
	cylinder(r=3.2, h=3, $fn=6);
    }
  }
  
  //dual extruder particular
  translate([e3dDiam2/2 + 7, -20, -e3dHeight1-e3dHeight2/2]) rotate([-90, 0, 0]) 
      cylinder(r=1.55, h=16);
  hull()
    {
      translate([e3dDiam2/2 + 7, -e3dDiam/2, -e3dHeight1-e3dHeight2/2]) rotate([-90, 90, 0]) 
	cylinder(r=3.2, h=3, $fn=6);
      translate([e3dDiam2/2 + 7, -e3dDiam/2, -30]) rotate([-90, 90, 0]) 
	cylinder(r=3.2, h=3, $fn=6);
    }

  //dual extruder particular
  translate([-(e3dDiam2/2 + 7), -20, -e3dHeight1-e3dHeight2/2]) rotate([-90, 0, 0]) 
      cylinder(r=1.55, h=30);
  hull()
    {
      translate([-(e3dDiam2/2 + 7), -2, -e3dHeight1-e3dHeight2/2]) rotate([-90, 90, 0]) 
	cylinder(r=3.2, h=3, $fn=6);
      translate([-(e3dDiam2/2 + 7), -2, -30]) rotate([-90, 90, 0]) 
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
      translate([-(e3dDiam-0.2)/2, 0, 0]) cube([e3dDiam-0.25, e3dDiam/2+3, e3dHeight1+e3dHeight2+mountB_H3]);
      translate([-36/2, e3dDiam/2+2, 0]) cube([36, 7, e3dHeight1+e3dHeight2+mountB_H3]);
    }
    
    translate([0, 0, -1]) cylinder(d=e3dDiam, h=1+mountB_H3);
    translate([0, 0, -1]) cylinder(d=e3dDiam2, h=e3dHeight1+e3dHeight2+mountB_H3+2);
    translate([0, 0, e3dHeight2+mountB_H3]) cylinder(d=e3dDiam, h=1+e3dHeight1);
    
    translate([-e3dDiam2/2-10, -1, mountB_H3-0.15]) cube([10.3, e3dDiam/2+3, e3dHeight2+0.3]);
    translate([e3dDiam2/2-0.3, -1, mountB_H3-0.15]) cube([10, e3dDiam/2+3, e3dHeight2+0.3]);
    
    translate([-e3dDiam/2-1, -1, -1]) cube([e3dDiam+2, e3dDiam2/2+1, 1+mountB_H3]);
    translate([-e3dDiam/2-1, -1, mountB_H3+e3dHeight2]) cube([e3dDiam+2, e3dDiam2/2+1, 1+e3dHeight1]);
    
    for(i=[-1, 1]) //general
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
