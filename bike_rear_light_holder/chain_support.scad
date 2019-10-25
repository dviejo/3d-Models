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
Width = 15;

holeMargin = (Length - 40)/2;

innerRad = 20;

difference()
{
    translate([0, -Width/2, 0]) cube([Length, Width, Height]);
    
    //main cavity
    translate([Length/2, 150/2, Height-5+innerRad]) rotate([90, 0, 0]) cylinder(r=innerRad, h=150);
    translate([Length/2-10, 0, Height-5]) cylinder(r=2, h=10, $fn=30);
    translate([Length/2+10, 0, Height-5]) cylinder(r=2, h=10, $fn=30);
    
    
    //nut and bolt holes
    translate([holeMargin, 0, -1])
    {
        cylinder(r=M4NutRad, h=M4NutHeight+1, $fn=6);
        translate([0, 0, M4NutHeight+1+0.4]) cylinder(r=2.5, h=Height, $fn=30);
    }
    translate([Length-holeMargin, 0, -1])
    {
        cylinder(r=M4NutRad, h=M4NutHeight+1, $fn=6);
        translate([0, 0, M4NutHeight+1+0.4]) cylinder(r=2.5, h=Height, $fn=30);
    }
    
}
