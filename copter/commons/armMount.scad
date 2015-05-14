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

// suavizar las superficies curvas
$fs= 1 ; 
$fa= 1 ; 

entryWidth = 50.75/2;
entryHeight = 18.25/2;
entryDepth = 12;

outputWidth = 45/2; //49/2;
outputHeight = 18/2;
outputDepth = 8 +15; //For modelling, this is the position of the further ellipse

module armMount(action)
{
    if(action == "add")
    {
        hull()
        {
            oval(w=entryWidth, h = entryHeight, height=entryDepth);
            translate([0, 0, entryDepth + outputDepth - 0.1])
                oval(w=outputWidth, h=outputHeight, height=0.1);
        }
    }
    else if(action == "remove")
    {
        //housing
        //left
        hull()
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
        translate([-15, 14.5/2+0.3, -1]) cube([30, 5, 20+1]);
        translate([-15, -14.5/2-5+0.39125, -1]) cube([30, 5, 20+1]);
        for(i=[1, -1])
        {
            translate([13*i, 14.6/2-sqrt(2.5*2.5+2.5*2.5)+0.7525, -1]) rotate(45) cube([5, 5, 20+1]);
            translate([13*i, -14.6/2-sqrt(2.5*2.5+2.5*2.5)-0.1, -1]) rotate(45) cube([5, 5, 20+1]);
        }
        //end housing
    } else //holes
    {
        //wire hole
        translate([0, 0, -5]) cylinder(d = wireDiameter, h = 10 +outputDepth + entryDepth);
        
        //attaching holes
        for(i=[1, -1])
            translate([13*i, -30, 12.5125]) rotate([-90, 0, 0]) cylinder(d=3.55, h = 60);
    }
}

*color("red")
translate([0, 36.30, 106.4]) //z=106.4
{
    rotate([0, 90, 0]) import("../stl/OpenRC_Quad_Alpha_Arm_Part_1.stl");
    rotate([180, 90, 0]) import("../stl/OpenRC_Quad_Alpha_Arm_Part_2.stl");
}

    difference()
    {
        armMount(action="add");
        armMount(action="remove");
        armMount(action="holes");
    }


translate([0,30,0]) difference()
{
    translate([-52/2, -20/2, 0]) cube([52, 20, entryDepth+outputDepth]);
    translate([0, 0, 1]) {
        difference()
        {
            armMount(action="add");
            armMount(action="remove");
        }
        armMount(action="holes");
    }
}

