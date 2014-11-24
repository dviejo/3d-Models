/**
 * baseStand.scad
 * 
 * created by Dviejo on 2014/Nov/17th
 * 
 * Experimental: this piece is to be atached to your bed. It has to be glued to it so no any part lay on the bed.
 * The part has to hold together base (cristal) and heatbed (mkI-mkII). Base has to be bigger than heatbed.
 * State: experimental. Use under your own risk.
 * 
 */

heatBedHeight=3; //check!!

module stand()
{
  difference()
  {
    cube([20, 20, 20]);
    
    translate([10, 20-heatBedHeight, 10]) cube([10+1, heatBedHeight+1, 10+1]);
    translate([2, 2, -1]) cube([16, 10, 22]);
    #translate([10+2, -1, 10+2]) rotate([-90, 0, 0]) cylinder(r=1.75, h=10);
    
  }
  
}

stand();