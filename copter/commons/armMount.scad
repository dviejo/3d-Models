/**
 * armMount.scad
 * 
 * This is the joint part for any arm in the copter
 * 
 * Created by Diego Viejo after the idea of OpenRC copter from Daniel Noree
 * 13/May/2015
 * 
 */

include<config.scad>

entryWidth = 50/2;
entryHeight = 18/2;
entryDepth = 14;

outputWidth = 49/2;
outputHeight = 18/2;
outputDepth = 6; //For modelling, this is the position of the further ellipse

module armMount(positive_shape = true)
{
    if(positive_shape)
    {
        hull()
        {
            oval(w=entryWidth, h = entryHeight, height=entryDepth);
            translate([0, 0, entryDepth + outputDepth - 0.1])
                oval(w=outputWidth, h=outputHeight, height=0.1);
        }
    }
    else
    {
        //wire hole
        translate([0, 0, -1]) cylinder(d = wireDiameter, h = 1.1 +outputDepth + entryDepth);
        
        //housing
        //left
        #hull()
        {
            translate([-10-20, -10, -0.1]) cube([20, 20, 0.1]);
            translate([-25.1, -10, 15]) cube([0.1, 20, 0.1]);
        }
        //right
        mirror([1, 0, 0]) hull()
        {
            translate([-10-20, -10, -0.1]) cube([20, 20, 0.1]);
            translate([-25.1, -10, 15]) cube([0.1, 20, 0.1]);
        }
        translate([-15, 14.5/2, -1]) cube([30, 5, 20+1]);
        translate([-15, -14.5/2-5, -1]) cube([30, 5, 20+1]);
        for(i=[1, -1])
        {
            translate([13*i, 14.6/2-sqrt(2.5*2.5+2.5*2.5)+0.4525, -1]) rotate(45) cube([5, 5, 20+1]);
            #translate([13*i, -14.6/2-sqrt(2.5*2.5+2.5*2.5-0.4525), -1]) rotate(45) cube([5, 5, 20+1]);
        }
    }
}

color("red")
translate([0, 36.0, 100.4]) //z=106.4
{
    rotate([0, 90, 0]) import("../stl/OpenRC_Quad_Alpha_Arm_Part_1.stl");
    rotate([180, 90, 0]) import("../stl/OpenRC_Quad_Alpha_Arm_Part_2.stl");
}

difference()
{
    armMount(positive_shape = true);
    armMount(positive_shape = false);

}