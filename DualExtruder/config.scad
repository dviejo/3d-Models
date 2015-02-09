

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
correction = (trackerDiam1 - trackerDiam) / 2;

PTFE = false;
ptfeTubeRad = 3.2;
simpleTubeRad = 1.9;
tubeRad = simpleTubeRad;
outputAngle = 30; //35; 
curvatura = 95; //122.5;
longStright = 10;

mountingHoleSep = 32;


e3dDiam = 16 + 0.725;
e3dDiam2 = 12 + 0.7;

e3dHeight1 = 3.75 + 0.425; 
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
  
  translate([0, 0, -15]) cylinder(r=1.85, h=50);
  #translate([22.00-10.3, -6-1.25, -e3dHeight1-1.65]) rotate([0, -90, 0]) cylinder(r=1.55, h=50);
  #translate([23.00, -6-1.25, -e3dHeight1-1.65]) rotate([0, -90, 0]) cylinder(r=3, h=11);
}
