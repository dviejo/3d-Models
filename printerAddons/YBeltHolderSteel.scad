/**
 * YBeltHolder for i3 Steel
 *
 * Created by DViejo
 * 27/Oct/2014
 *
 *  If you like the original prusa's ybeltholder part, then you'll love to use this one
 * in your i3 steel as it allows for a straight belt. This should be used with the 
 * YIdlerSteel also included in this project 
 */

belt_tooth_distance = 2;
belt_tooth_ratio = 0.8; //0.675//0.5;


module belt_holder_base(){
 translate([-33-8.5, 0,-1-4.5]) cube([33,26,16+4.5]);
 translate([-33-8.5, 22, -1-4.5]) cube([33, 4, 16+9]);	
}

module belt_holder_beltcut(){
 position_tweak=-0.2;
 // Belt slit
 translate([-66,-0.5+10,belt_tooth_distance+1]) cube([67,0.8,15]);
 // Smooth insert cutout
 translate([-66,-0.5+10,12]) rotate([45,0,0]) cube([67,15,15]);
 // Individual teeth
 for ( i = [0 : 23] ){
  translate([0-i*belt_tooth_distance+position_tweak,-0.5+8,3]) cube([belt_tooth_distance-belt_tooth_ratio,3,15]);
 }
 // Middle opening
 translate([-2-25,-1,3]) cube([4,11,15]);	
}

module belt_holder_holes(){
 translate([-45.5,0,7.5]) rotate([-90,0,0]) cylinder(h=30, r=1.7, $fn=10);
 
 //new holes
 translate([-25 -23.5/2, 15, 6.5 + 17.5/2]) rotate([-90,0,0]) cylinder(h=15, r=1.7, $fn=10);
 translate([-25 +23.5/2, 15, 6.5 + 17.5/2]) rotate([-90,0,0]) cylinder(h=15, r=1.7, $fn=10);
 translate([-25 -23.5/2, 15, 6.5 - 17.5/2]) rotate([-90,0,0]) cylinder(h=15, r=1.7, $fn=10);
 translate([-25 +23.5/2, 15, 6.5 - 17.5/2]) rotate([-90,0,0]) cylinder(h=15, r=1.7, $fn=10);
 
 //nuts
 translate([-25 -23.5/2, 18, 6.5 + 17.5/2]) rotate([-90,0,0]) cylinder(h=4, r=6.75/2, $fn=6);
 translate([-25 +23.5/2, 18, 6.5 + 17.5/2]) rotate([-90,0,0]) cylinder(h=4, r=6.75/2, $fn=6);
 hull()
 {
    translate([-25 -23.5/2, 18, 6.5 - 17.5/2]) rotate([-90,0,0]) cylinder(h=4, r=6.75/2, $fn=6);
    translate([-25 -23.5/2, 18, 6.5 - 17.5]) rotate([-90,0,0]) cylinder(h=4, r=6.75/2, $fn=6);
 }
 
 hull()
 {
    translate([-25 +23.5/2, 18, 6.5 - 17.5/2]) rotate([-90,0,0]) cylinder(h=4, r=6.75/2, $fn=6);
    translate([-25 +23.5/2, 18, 6.5 - 17.5]) rotate([-90,0,0]) cylinder(h=4, r=6.75/2, $fn=6);
 }
}

// Final part
module belt_holder(){
 difference(){
  belt_holder_base();
  belt_holder_beltcut();
  belt_holder_holes();
 }
}

belt_holder();