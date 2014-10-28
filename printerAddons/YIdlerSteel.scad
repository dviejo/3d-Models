/**
 * YIdlerSteel for i3 Steel
 *
 * Created by DViejo
 * 27/Oct/2014
 *
 *  This part allows you to use 623 bearings in your i3 Steel. It makes possible to have
 * a straight belt when used with YBeltHolderSteel part (also included in this project)
 */


distEjeIdler = 38 - 25.5 -4-3.5; 

width = 22;

module idlerBlock()
{
  hull()
  {
    cube([width, 15, 18.5]);
    translate([width, 15+10, 7+1.5]) rotate([0, -90, 0]) cylinder(r=7+1.5, h=width);
  }
}

module idlerHoles()
{
    translate([width+1, 15+10+1.5, 7+1.5]) rotate([0, -90, 0]) cylinder(r=4, h=width+2);
    
    translate([3, -1, 3]) cube([width -6, 35, 16]);
    
    #translate([width+1, 5, 7+1.5+distEjeIdler]) rotate([0, -90, 0]) cylinder(r=1.8, h=width+2);

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