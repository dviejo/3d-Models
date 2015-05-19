/**
 * copterArm.scad
 * 
 * Created by Diego Viejo
 * 19/May/2015
 * 
 */

include<config.scad>

use<motorMount.scad>

use<armMount.scad>

length = 184; //from the beginning of armMount/malePart to the center of motorMount

malePart();

translate([0, length, 0]) rotate(-90) motorMount();

rotate([-90,0,0])
{
    hull()
    {
        translate([0, 0, entryDepth + outputDepth - 0.1])
            oval(w=outputWidth, h=outputHeight, height=0.1);

        translate([0, 0, 140-20])
            oval(w=25/2+10*10/100, h=outputHeight, height=1);
    }
    
    for(i=[-10:0])
    {
        hull()
        {
            translate([0, 0, 140+i*2])
                oval(w=25/2+i*i/100, h=outputHeight, height=1);
            translate([0, 0, 140+(i+1)*2])
                oval(w=25/2+(i+1)*(i+1)/100, h=outputHeight, height=1);
        }
    }
    
    for(i=[0:29])
    {
        hull()
        {
            translate([0, 0, 140+i])
                oval(w=25/2+i*i/100, h=outputHeight, height=1);
            translate([0, 0, 140+i+1])
                oval(w=25/2+(i+1)*(i+1)/100, h=outputHeight, height=1);
        }
    }
    
    nestedHull()
    {
        translate([0, 0, 140+30])
            oval(w=25/2+30*30/100, h=outputHeight, height=1);
        
        translate([0, 0, length-5])
            oval(w=55/2, h=outputHeight, height=1);
        translate([0, 0, length-1])
            oval(w=50/2, h=outputHeight, height=1);
    }
}