// PRUSA iteration3
// X carriage mod by DViejo
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

include <../configuration.scad>
use <inc/bearing.scad>

module x_carriage_base(beltOffset = 0){
 // Small bearing holder
 translate([-33/2,0,0]) rotate([0,0,90]) horizontal_bearing_base(1);
 // Long bearing holder
 translate([-33/2,x_rod_distance,0]) rotate([0,0,90]) horizontal_bearing_base(2);
 // Base plate
 translate([-33,-11.5,0]) cube([33,68,7]);
 // Belt holder base
 translate([-33,21+beltOffset,0]) cube([33,16.5-beltOffset,17]);
}

module x_carriage_beltcut(beltOffset = 0){
 // Cut in the middle for belt
 translate([-2.5-16.5, 19+beltOffset, 7]) cube([5.5,13,15]);
 // Cut clearing space for the belt
 translate([-38, 10 ,7]) cube([40,8+beltOffset,15]);
 // Belt slit
 translate([-66, 21.5+10.5+beltOffset,6]) cube([67,0.85,15]);
 // Smooth entrance
 translate([-66,21.5+10.5+beltOffset,14]) rotate([45,0,0]) cube([67,15,15]);
 // Teeth cuts
 for ( i = [0 : 23] ){
  translate([0-i*belt_tooth_distance,21.5+8.75+beltOffset,6]) 
    cube([belt_tooth_distance-belt_tooth_ratio,2.6,15]);
 }
}

module x_carriage_holes(beltOffset=0){
 // Small bearing holder holes cutter
 translate([-33/2,0,0]) rotate([0,0,90]) horizontal_bearing_holes(1);
 // Long bearing holder holes cutter
 translate([-33/2,45,0]) rotate([0,0,90]) horizontal_bearing_holes(2);
  // Extruder mounting holes
  translate([-16.5+12,37.50+beltOffset,-1])cylinder(r=1.7, h=20, $fn=8);
  translate([-16.5+12,37.50+beltOffset,10])cylinder(r=3.15, h=20, $fn=6); 
  translate([-16.5-12,37.50+beltOffset,-1])cylinder(r=1.7, h=20, $fn=8);
  translate([-16.5-12,37.50+beltOffset,10])cylinder(r=3.15, h=20, $fn=6); 	
}

module x_carriage_fancy(){
 // Top right corner
 translate([13.5,-5,0]) translate([0,45+11.5,-1]) rotate([0,0,45]) translate([0,-15,0]) cube([30,30,20]);
 // Bottom right corner
 translate([0,5,0]) translate([0,-11.5,-1]) rotate([0,0,-45]) translate([0,-15,0]) cube([30,30,20]);
 // Bottom ĺeft corner
 translate([-33,5,0]) translate([0,-11.5,-1]) rotate([0,0,-135]) translate([0,-15,0]) cube([30,30,20]);
 // Top left corner
 translate([-33-13.5,-5,0]) translate([0,45+11.5,-1]) rotate([0,0,135]) translate([0,-15,0]) cube([30,30,20]);	
}

// Final part
module x_carriage(beltOffset=-4){
 difference(){
  x_carriage_base(beltOffset);
  x_carriage_beltcut(beltOffset);
  x_carriage_holes(beltOffset);
  x_carriage_fancy();
 }
}

x_carriage();