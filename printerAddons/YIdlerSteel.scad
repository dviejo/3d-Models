/**
 * YIdlerSteel for i3 Steel
 *
 * Created by DViejo
 * 27/Oct/2014
 *
 *  This part allows you to use 624 bearings in your i3 Steel. It makes possible to have
 * a straight belt when used with YBeltHolderSteel part (also included in this project). This can be used 
 * in a 'vanilla' i3steel although it is designed to be used with the model sold in moebyus.com (Madrid - Spain)
 */

 
pulleyInnerRad = 2 * 1.1; //change 2 by 1.65 for 623zz bearings
pulleyWidth = 5 + 1;

height = 6;
motorHeight = 30;

//watch();
print();


module idlerPlate()
{
  difference()
  {
    hull()
    {
      cube([35, 10, height]);
      translate([1.5, 13.5, 0]) cylinder(r=1.5, h=height);
      translate([motorHeight, 15, 0]) cylinder(r=5, h=height);
    }
    //bearing beam hole
    translate([motorHeight, 15, -1]) cylinder(r=pulleyInnerRad, h=height+2);
    
    //frame attaching hole
    #translate([26.5, -1, height/2]) rotate([-90, 0, 0]) cylinder(r=1.65, h=15);
    //nut
    hull()
    {
      translate([26.5, 6, height/2]) rotate([-90, 0, 0]) cylinder(r=6.75/2, h=4, $fn=6);
      translate([26.5, 6, height]) rotate([-90, 0, 0]) cylinder(r=6.75/2, h=4, $fn=6);
    }
  }
}

module watch()
{
  translate([height/2, 0, 0]) rotate([0, -90, 0]) idlerPlate();
  translate([height/2 + 13, 0, 0]) rotate([0, -90, 0]) idlerPlate();
  
  %translate([(13+pulleyWidth)/2, 15, 30]) rotate([0, -90, 0]) cylinder(r=13/2, h=pulleyWidth);
  
}

module print()
{
  idlerPlate();
  translate([0, -2, 0]) mirror([0, -1, 0]) idlerPlate();
}