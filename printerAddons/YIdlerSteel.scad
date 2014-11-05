/**
 * YIdlerSteel for i3 Steel
 *
 * Created by DViejo
 * 27/Oct/2014
 *
 *  This part allows you to use 623 bearings in your i3 Steel. It makes possible to have
 * a straight belt when used with YBeltHolderSteel part (also included in this project)
 */

 
pulleyInnerRad = 2 * 1.1; //1.65 for 623zz
pulleyWidth = 9 + 1;

boltHoleDesp = 6.5; //check!!!

height = 5;
width = boltHoleDesp*2 + 12;

module idlerBlock()
{
  translate([-width/2, 0, 0]) cube([width, 17, height]);
  
  translate([pulleyWidth/2, 0, 0])
  hull()
  {
    translate([0, 5 + 5.5, 15]) rotate([0, 90, 0]) cylinder(r=4.5, h=5);
    translate([0, 9, 0]) cube([5, 8, height]);
  }

  translate([-pulleyWidth/2-3, 0, 0])
  hull()
  {
    translate([-2, 5 + 5.5, 15]) rotate([0, 90, 0]) cylinder(r=4.5, h=5);
    translate([-2, 9, 0]) cube([5, 8, height]);
  }
  
  %translate([-pulleyWidth/2, 5 + 5.5, 15]) rotate([0, 90, 0]) cylinder(r=9, h=pulleyWidth);
}

module idlerHoles()
{
  //pulley rod
  #translate([-width/2-1, 5 + 5.5, 15]) rotate([0, 90, 0]) cylinder(r=pulleyInnerRad, h=width+2);
  
  translate([boltHoleDesp, 5, -1]) cylinder(r=1.65, h=height+2);
  translate([-boltHoleDesp, 5, -1]) cylinder(r=1.65, h=height+2);

  //nuts
  translate([boltHoleDesp, 5, height-2.5]) cylinder(r=6.75/2, h=4, $fn=6);
  translate([-boltHoleDesp, 5, height-2.5]) cylinder(r=6.75/2, h=4, $fn=6);
  
  translate([-pulleyWidth/2, 5 + 5.5, 15]) rotate([0, 90, 0]) cylinder(r=9+2, h=pulleyWidth);
  
  
  //fancy cuts
  translate([pulleyWidth/2+4, 17, -1]) rotate(15)
    translate([5,0,0]) rotate(180) 
      cube([5, 17, 40]);
  
  mirror([1, 0, 0])
  translate([pulleyWidth/2+4, 17, -1]) rotate(15)
    translate([5,0,0]) rotate(180) 
      cube([5, 17, 40]);
}


module idler()
{
  difference()
  {
    idlerBlock();
    idlerHoles();
  }
}


idler();