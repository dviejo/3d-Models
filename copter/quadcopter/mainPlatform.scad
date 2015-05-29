/**
 * MainPlatform for a quadcopter
 * 
 * Created by Diego Viejo
 * 28/May/2015
 * 
 */

include<config.scad>
include<../commons/config.scad>

use<../commons/armMount.scad>
use<../commons/copterArm.scad>


difference()
{
    union()
    {
        difference()
        {
            oval(w=baseWidth, h=baseLength, height=baseHeight);
            translate([0, 0, 4]) oval(w=baseWidth-wallThick, h=baseLength-wallThick, height=baseHeight-4*2);
        }
    for(i=[45, 135, -45, -135])
    {
        intersection()
        {
            rotate(i) translate([0,baseWidth-15,0])
            {
                difference()
                {
                    linear_extrude(height=baseHeight)  projection() minkowski() {
                        hull() malePart();
                        sphere(4);
                    }
                }
            }
            oval(w=baseWidth, h=baseLength, height=baseHeight);
        }
    }    
        
    }

    for(i=[45, 135, -45, -135])
        rotate(i) translate([0,baseWidth-15,baseHeight/2])
            femalePart();

    //Uncomment next line to get the lower half
    translate([-300, -300, baseHeight/2]) cube([600,600,100]);
    //Uncomment next line to get the upper half
    //translate([-300, -300, -1]) cube([600,600,baseHeight/2+1]);
}


for(i=[45, 135, -45, -135])
    rotate(i) translate([0,baseWidth-15,baseHeight/2]) import("../stl/copterArm.stl");
