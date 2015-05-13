/**
 * config.scad
 * 
 * Constants and common methods used for the multi-copter
 * 
 */

//wire openning
wireDiameter = 8;

module oval(w,h, height, center = false) {
 scale([1, h/w, 1]) cylinder(h=height, r=w, center=center);
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