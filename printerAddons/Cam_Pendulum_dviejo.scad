/**
 * 
 * Cam Pendulum
 * 
 * Modified cam pendulum for Dondolo extruder. Visit http://www.thingiverse.com/thing:673816
 * 
 * Created by Diego Viejo
 * 
 */

height = 4;
diam1 = 15.2275;
diam2 = 42.4;
screewsRad = diam1/2 + 9.20;
extraWidth = 1; //This is the main difference from the original part

module camPendulum()
{
  difference()
  {
    cylinder(d=diam2, h=height, $fn=200);
    
    translate([0, 0, -1]) 
    {
      cylinder(d = diam1, h = height+2, $fn=100);
      
      for(i=[-1, 1]) rotate(i*43.3) translate([0, -screewsRad, 0]) 
      {
	cylinder(r=1.65, h=height+2, $fn=50);
	translate([0, 0, 2.5]) cylinder(r=2.85,, h=height, $fn=50); 
      }

      translate([0, -0.5, 0]) rotate(9) cube([diam2/2, diam2/2, height+2]);
      translate([diam2/2+1.7+extraWidth, -10, 0]) rotate(25) cube([diam2, diam2, height+2]);


      mirror([1, 0, 0]) 
      {
	translate([0, -0.5, 0]) rotate(9) cube([diam2/2, diam2/2, height+2]);
	translate([diam2/2+1.7+extraWidth, -10, 0]) rotate(25) cube([diam2, diam2, height+2]);
      }
      
      translate([-diam2/2, diam1, 0]) cube([diam2, diam2/2, height+2]);
    }
    
    
  }
}

*translate([-92, -92, -17])
import("/home/dviejo/Documents/Piezas3D/Dondolo_v1.0b/Camma_Pendulum.STL");

camPendulum();