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

holeSeparation = 24;

holeSeparation2 = 14;

height = 15.5+1.75;

module heels()
{
  difference()
  {
    translate([-8/2, 0, 0]) 
    {
      cube([8, 32, height]);
    }
    
    //belt slit
    translate([-4.5, (32-7)/2, height-0.75]) cube([9, 7, 1]);
    
    for(i = [-1, 1])
    {
      //bolts
      translate([0, (32-i*holeSeparation)/2, -1]) cylinder(r=1.65, h=height-5, $fn=10);
      
      //nuts
      hull()
      {
	translate([0, (32+i*holeSeparation)/2, 2.5]) cylinder(r=6.625/2, h=3, $fn=6);
	translate([10, (32+i*holeSeparation)/2, 2.5]) cylinder(r=6.625/2, h=3, $fn=6);
      }
      
      translate([0, (32+i*holeSeparation2)/2, height/2]) cylinder(r=1.65, h=height/2+1, $fn=10);    
      
      //nuts
      hull()
      {
	translate([0, (32+i*holeSeparation2)/2, height-5.5]) cylinder(r=6.625/2, h=3, $fn=6);
	translate([10, (32+i*+holeSeparation2)/2, height-5.5]) cylinder(r=6.625/2, h=3, $fn=6);
      }
    }
    
    //Clearance
    translate([0, (32-holeSeparation2-7)/2, height+0.1]) 
      rotate([-35, 0, 0]) 
	translate([-8/2-1, -10, -height]) 
	  cube([10, 8+2, height]);
    translate([0, (32+holeSeparation2+7)/2, height+0.1]) 
      rotate([35, 0, 0]) 
	translate([-8/2-1, 0, -height]) 
	  cube([10, 8+2, height]);
  }
}

module head()
{
  difference()
  {
    translate([-8/2, 11/2, 0]) 
    {
      cube([8, 32-11, 4]);
    }
    
    //bolts
    for(i = [-1, 1])
    {
      translate([0, (32+i*holeSeparation2)/2, -1]) cylinder(r=1.65, h=height+2, $fn=10);
      translate([0, (32+i*holeSeparation2)/2, -1]) cylinder(r=6.65/2, h=2.5, $fn=10);
    }

    //teeth
    for ( i = [0 : 8] ){
      translate([10.35-i*belt_tooth_distance,(32-7)/2,3]) cube([belt_tooth_distance-belt_tooth_ratio,7,6]);
    }

  }
}

/*
module belt_holder_base(){
 translate([-33-8.5, 0,-1-8]) cube([33,26,16+6]);
 translate([-33-8.5, 22, -1-8]) cube([33, 4, 16+16]);	
}

module belt_holder_beltcut(){
 position_tweak=-0.2;
 // Belt slit
 translate([-66,-0.5+10,belt_tooth_distance+1]) cube([67,0.8,15]);
 // Smooth insert cutout
 translate([-66,-0.5+10,12]) rotate([45,0,0]) cube([67,15,15]);
 // Individual teeth
 for ( i = [0 : 23] ){
  translate([0-i*belt_tooth_distance+position_tweak,-0.5+8,3]) cube([belt_tooth_distance-belt_tooth_ratio,2.8,15]);
 }
 // Middle opening
 translate([-2-25,-1,3]) cube([4,11,15]);	
}

module belt_holder_holes(){
 translate([-45.5,0,7.5]) rotate([-90,0,0]) cylinder(h=30, r=1.7, $fn=10);
 
 //new holes
 translate([-25 - 17.5/2, 15, 6.5 + 23.5/2]) rotate([-90,0,0]) cylinder(h=15, r=1.7, $fn=10);
 translate([-25 + 17.5/2, 15, 6.5 + 23.5/2]) rotate([-90,0,0]) cylinder(h=15, r=1.7, $fn=10);
 translate([-25 - 17.5/2, 15, 6.5 - 23.5/2]) rotate([-90,0,0]) cylinder(h=15, r=1.7, $fn=10);
 translate([-25 + 17.5/2, 15, 6.5 - 23.5/2]) rotate([-90,0,0]) cylinder(h=15, r=1.7, $fn=10);

 
 //nuts
 translate([-25 - 17.5/2, 20, 6.5 + 23.5/2]) rotate([-90,0,0]) cylinder(h=4, r=6.65/2, $fn=6);
 translate([-25 + 17.5/2, 20, 6.5 + 23.5/2]) rotate([-90,0,0]) cylinder(h=4, r=6.65/2, $fn=6);
 hull()
 {
    translate([-25 - 17.5/2, 18, 6.5 - 23.5/2]) rotate([-90,0,0]) cylinder(h=4, r=6.65/2, $fn=6);
    translate([-25 - 17.5/2, 18, 6.5 - 23.5]) rotate([-90,0,0]) cylinder(h=4, r=6.65/2, $fn=6);
 }
 
 hull()
 {
    translate([-25 + 17.5/2, 18, 6.5 - 23.5/2]) rotate([-90,0,0]) cylinder(h=4, r=6.65/2, $fn=6);
    translate([-25 + 17.5/2, 18, 6.5 - 23.5]) rotate([-90,0,0]) cylinder(h=4, r=6.65/2, $fn=6);
 }
 
 rotate([-50, 0, 0]) 
   translate([-33-8.5-1, -7, -20])
    cube([35, 25, 19]);
}

// Final part
module belt_holder(){
 difference(){
  belt_holder_base();
  translate([0, 0, -2]) belt_holder_beltcut();
  belt_holder_holes();
 }
}
*/


translate([25, 0, 4]) rotate([0, -90, 0])
heels();
translate([0, 0, 4]) rotate([0, 180, 0]) head();