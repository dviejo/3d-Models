/**
 * YIdlerSteel for i3 Steel
 *
 * Created by DViejo
 * 27/Oct/2014
 *
 *  This part allows you to use 623 bearings in your i3 Steel. It makes possible to have
 * a straight belt when used with YBeltHolderSteel part (also included in this project)
 */

pulleyWidth = 15 + 1;

boltHoleDesp = 6.5; //check!!!

height = 5;
width = boltHoleDesp*2 + 10;

module idlerBlock()
{
  translate([-width/2, 0, 0]) cube([width, 17, height]);
  
  translate([pulleyWidth/2-3, 0, 0])
  hull()
  {
    translate([0, 5 + 5.5, 15]) rotate([0, 90, 0]) cylinder(r=4, h=3);
    translate([0, 9, 0]) cube([3, 8, height]);
  }

  translate([-pulleyWidth/2, 0, 0])
  hull()
  {
    translate([0, 5 + 5.5, 15]) rotate([0, 90, 0]) cylinder(r=4, h=3);
    translate([0, 9, 0]) cube([3, 8, height]);
  }
}

module idlerHoles()
{
  //pulley rod
  #translate([-width/2-1, 5 + 5.5, 15]) rotate([0, 90, 0]) cylinder(r=1.65, h=width+2);
  
  translate([boltHoleDesp, 5, -1]) cylinder(r=1.65, h=height+2);
  translate([-boltHoleDesp, 5, -1]) cylinder(r=1.65, h=height+2);

  //nuts
  translate([boltHoleDesp, 5, height-2]) cylinder(r=6.75/2, h=4, $fn=6);
  translate([-boltHoleDesp, 5, height-2]) cylinder(r=6.75/2, h=4, $fn=6);

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