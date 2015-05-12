/**
 * motorMount.scad
 * 
 * Common piece for holding a brushless motor
 * 
 * Created by Diego Viejo after the idea of OpenRC copter from Daniel Noree
 * 21/May/2015
 * 
 */

outerDiam = 37;
innerDiam = 32;

height = 26;

platformHeight = 7;
platformWidth = 3.75;

axleDiam = 3.75;

//wire openning
wireDiameter = 8;

module motorMount() translate([0, 0, -(platformHeight + platformWidth + wireDiameter/2)])
{
    difference()
    {
        cylinder(d=outerDiam, h=height);
        
        translate([0, 0, -1]) cylinder(d=innerDiam, h=1+platformHeight);
        translate([0, 0, platformHeight + platformWidth]) cylinder(d=innerDiam, h=height);
        
        //Motor axle if exists
        cylinder(d=axleDiam, h=height, $fn=20);
        
        //Mounting holes
        for(i=[1:2:8])
        {
            echo(i);
            echo(45*i);
            rotate(45*i) hull()
            {
                translate([0, 6, 0]) cylinder(d=3, h=height, $fn=20);
                translate([0, 12, 0]) cylinder(d=3, h=height, $fn=20);
            }
        }
        
        //wire openning
        #translate([innerDiam/2-1, 0, platformHeight + platformWidth + wireDiameter/2]) rotate([0, 90, 0]) cylinder(d2=wireDiameter, d1=wireDiameter+2, h=(outerDiam-innerDiam)/2+1);
    }
}


motorMount();