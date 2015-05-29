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
            difference()
            {
                translate([0, 0, 4]) oval(w=baseWidth-wallThick, h=baseLength-wallThick, height=baseHeight-4*2);
                
                //unions
                for(i=[1,-1])
                {
                    translate([i*(baseWidth-wallThick), 0, 0]) unionBeam(action="add");
                    translate([0, i*(baseLength-wallThick), 0]) unionBeam(action="add");
                }
            }
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

    //unions
    for(i=[1,-1])
    {
        translate([i*(baseWidth-wallThick), 0, 0]) unionBeam(action="remove");
        translate([0, i*(baseLength-wallThick), 0]) unionBeam(action="remove");
        translate([i*(baseWidth-wallThick), 0, 0]) unionBeam(action="nut");
        translate([0, i*(baseLength-wallThick), 0]) unionBeam(action="nut");
    }

    //Uncomment next line to get the lower half
    //translate([-300, -300, baseHeight/2]) cube([600,600,100]);
    //Uncomment next line to get the upper half
    //translate([-300, -300, -1]) cube([600,600,baseHeight/2+1]);
}


for(i=[45, 135, -45, -135])
    rotate(i) translate([0,baseWidth-15,baseHeight/2]) import("../stl/copterArm.stl");


module mainElectronics()
{
}

module unionBeam(action="add", height=baseHeight)
{
    if(action=="add")
    {
        cylinder(r=5, h=height);
    }
    else if(action=="remove")
    {
        translate([0, 0, -1]) cylinder(r=1.65, h=height+2);
    }
    else 
    {
        echo(height);
        translate([0, 0, height-2.5]) cylinder(r=3.15, h=height+2, $fn=6);
    }
}