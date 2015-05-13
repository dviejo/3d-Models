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
        hull()
        {
            translate([-10-20, -10, -0.1]) cube([20, 20, 0.1]);
            translate([-25.1, -10, 14]) cube([0.1, 20, 0.1]);
        }
        //right
        mirror([1, 0, 0]) hull()
        {
            translate([-10-20, -10, -0.1]) cube([20, 20, 0.1]);
            translate([-25.1, -10, 14]) cube([0.1, 20, 0.1]);
        }
        #translate([-15, 14.6/2, -1]) cube([30, 5, 20]);
        #translate([-15, -14.6/2-5, -1]) cube([30, 5, 20]);
    }
}


difference()
{
    armMount(positive_shape = true);
    armMount(positive_shape = false);

}