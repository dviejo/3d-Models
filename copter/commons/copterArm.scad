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

        translate([0, 0, length-44-20])
            oval(w=25/2+10*10/100, h=outputHeight, height=1);
    }
    
    for(i=[-10:0])
    {
        hull()
        {
            translate([0, 0, length-44+i*2])
                oval(w=25/2+i*i/100, h=outputHeight, height=1);
            translate([0, 0, 140+(i+1)*2])
                oval(w=25/2+(i+1)*(i+1)/100, h=outputHeight, height=1);
        }
    }
    
    for(i=[0:29])
    {
        hull()
        {
            translate([0, 0, length-44+i])
                oval(w=25/2+i*i/100, h=outputHeight, height=1);
            translate([0, 0, length-44+i+1])
                oval(w=25/2+(i+1)*(i+1)/100, h=outputHeight, height=1);
        }
    }
    
    nestedHull()
    {
        translate([0, 0, length-44+30])
            oval(w=25/2+30*30/100, h=outputHeight, height=1);
        
        translate([0, 0, length-1])
            oval(w=55/2, h=outputHeight, height=1);

        translate([0, 0, length]) rotate([-1, 0, 0]) translate([0, 0, 1/500+1]) 
            oval(w=56/2+1/2 , h=outputHeight, height=1);
    }
    translate([0, 0, length]) 
    difference()
    {
        ovalBlend();
        hull()
        {
            translate([0, -10, 20]) rotate([-100, 0, 0]) cylinder(d1=35, d2=8, h=100);
            translate([0, 0, 60]) rotate([-90, 0, 0]) cylinder(d1=35, d2=8, h=100);
        }
    }

}

*difference()
{
    ovalBlend();
    hull()
    {
        translate([0, 0, 20]) rotate([-100, 0, 0]) cylinder(d1=35, d2=8, h=100);
        translate([0, 0, 60]) rotate([-90, 0, 0]) cylinder(d1=35, d2=8, h=100);
    }
}

color("red")
translate([0, 106.4, -36.3]) 
    rotate([0, 90, 0]) rotate(-90) 
        import("../stl/OpenRC_Quad_Alpha_Arm_Part_1.stl");

module ovalBlend(start=0, end=103)
{
    aux = end*end/100;
    change = 50;
    for(i=[start:end])
    {
//        hull()
        {
            if(i<change)
            {
                rotate([-(i), 0, 0]) translate([0, 0, (i)*(i)/500 + i*0.75]) 
                    oval(w=56/2+i/3 , h=outputHeight, height=1);
                rotate([-(i+1), 0, 0]) translate([0, 0, (i+1)*(i+1)/500 + (i+1)*0.75]) 
                    oval(w=56/2+(i+1)/3 , h=outputHeight, height=1);
            }
            else
            {
                rotate([-(i), 0, 0]) translate([0, 0, (i)*(i)/500 +change*0.75 + (i-change)/3]) 
                    oval(w=56/2+change/3-(i-change)*0.8 , h=outputHeight, height=1);
                rotate([-(i+1), 0, 0]) translate([0, 0, (i+1)*(i+1)/500 +change*0.75 + (i+1-change)/3]) 
                    oval(w=56/2+change/3-(i+1-change)*0.8 , h=outputHeight, height=1);
            }
        }
    }
}