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

heatBedHeight=1.61 - 0.1; 

magnetRad = 17.5/2;
magnetHeight = 5;

side = 31;
height = 20;

module stand()
{
  difference()
  {
    cube([side, side, height]);
    
    //heatbed dock
    difference()
    {
      translate([-1, -1, height-heatBedHeight]) cube([side+2, 11, heatBedHeight+1]);
      translate([side-3, 10-3, height-heatBedHeight-1]) cylinder(r=1.3, h=1+heatBedHeight/2, $fn=15); 
    }
    
    //height adjustment chamber
    difference()
    {
      translate([side - 3, 10 - 3, 3]) cylinder(r=12, h=13);
      translate([side, 0, 0]) cylinder(r=3.5, h=height);
    }
    
    //connection beam
    translate([side-3, 10 - 3, -1]) cylinder(r=1.75, h=10, $fn=15);
    
    //magnet hub
    #translate([magnetRad+2, 10 + (side-10)/2, height-(2*magnetHeight)]) cylinder(r=magnetRad*1.04, h=2*magnetHeight+1);
    
  }
  
}

module wheel()
{
  difference()
  {
    union()
    {
      cylinder(r=10, h=3);
      cylinder(r=5, h=4);
    }
    
    translate([0, 0, -1]) cylinder(r=1.7, h=5, $fn=15);
    translate([0, 0, 1.5]) cylinder(r=3.2, h=3, $fn = 6);
  }
}

stand();
translate([50, side/2, 0]) wheel();

translate([0, -10, 0]) mirror([0, -1, 0])
{
  stand();
  translate([50, side/2, 0]) wheel();
}
