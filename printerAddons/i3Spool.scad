/**
 * i3 Spool holder
 * 
 * Created by Diego Viejo
 * 
 */

height = 10;
dist = 90;

holder();

translate([100,150,0]) rotate(180) holder();

module holder()
difference()
{
    nestedHull()
    {
        cylinder(d=25, h=height);
        translate([0,40,0]) cylinder(d=25, h=height);
        translate([dist/2,150/2+40,0]) cylinder(d=16, h=height);
        translate([dist,150+40,0]) cylinder(d=25, h=height);
        
    }
    
    hull()
    {
        translate([0, -20, -1]) cylinder(d=6.2, h=height+2);
        translate([0, 40-24/2, -1]) cylinder(d=6.2, h=height+2);
    }
    
    hull()
    {
        translate([dist, 150+40, -1]) cylinder(d=8.25, h=height+2);
        translate([dist, 170+40, -1]) cylinder(d=9, h=height+2);
    }
}

//auxiliary method
module nestedHull()
{
  for(i=[0:$children-2])
    hull()
    {
      children(i);
      children(i+1);
    }
}