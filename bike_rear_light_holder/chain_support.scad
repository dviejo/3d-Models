/**
 * Chain support
 * 
 * Created by Diego Viejo
 * 8th April 2019
 *
 * This is a replacement part for a bike security chain holder
 *
 */
 
M4NutRad = 8/2;
M4NutHeight = 3.2;

Height = 15;
Length = 55;
Width = 10;

holeMargin = (Length - 40)/2

innerRad = 20;

difference()
{
    cube([Length, Width, Height]);
    
    //main cavity
    translate([0, 150/2, Height/2]) rotate([90, 0, 0]) cylinder(r=innerRad, h=150);
    
    //nut and bolt holes
    translate([holeMargin, 0, -1])
    {
        cylinder(r=M4NutRad, h=M4NutHeight+1, $fn=6);
        translate([0, 0, M4NutHeight+1+0.4]) cylinder(r=2.5, h=Height);
    }
    translate([Length-holeMargin, 0, -1])
    {
        cylinder(r=M4NutRad, h=M4NutHeight+1, $fn=6);
        translate([0, 0, M4NutHeight+1+0.4]) cylinder(r=2.5, h=Height);
    }
    
}
