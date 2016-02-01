/**
 * Table beam
 * 
 * Created by Diego Viejo
 * 01/Feb/2016
 * 
 */


length = 165;
extraLength = 20;

width = 40;

difference()
{
    cube([length+extraLength*2, width, 20+5]);
    
    translate([-1, -1, 5]) cube([extraLength+1, width+2, 20+1]);
    translate([length+extraLength, -1, 5]) cube([extraLength+1, width+2, 20+1]);
    
    for(i=[-1, 1]) for(j=[-1, 1])
        translate([(length+extraLength*2)/2+j*(length+extraLength)/2, width/2+i*width/4, -1]) cylinder(d=4, h=5+2, $fn=15);
}