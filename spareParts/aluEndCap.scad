/**
 * AluEndCap.scad
 * 
 * Created by Diego Viejo
 * 01/Feb/2016
 * 
 */

height = 10;

side = 20;
wall = 4;
typeWidth = 5;
typeDepth = 6.35;

difference()
{
    union()
    {
        cube(side+wall*2);
        translate([0, 0, -20]) seta();
    }
    
    translate([wall-1/2, wall-1/2, height])
    difference()
    {
        cube([side+1, side+1, side+2*wall]);
        
        translate([(side+1-typeWidth)/2, -1, -1])
            cube([typeWidth, 1 + typeDepth*0.85, side+2*wall+2]);
        translate([(side+1-typeWidth)/2, side+1-typeDepth*0.85, -1])
            cube([typeWidth, 1 + typeDepth, side+2*wall+2]);
        translate([-1, (side+1-typeWidth)/2, -1])
            cube([1 + typeDepth*0.85, typeWidth, side+2*wall+2]);
        translate([side+1-typeDepth*0.85, (side+1-typeWidth)/2, -1])
            cube([1 + typeDepth, typeWidth, side+2*wall+2]);
    }
}

module seta()
rotate([-90, 0, 0]) 
difference()
{
    cylinder(r=6.35, h=legLength);

    
    translate([5.75, -15/2, -1]) cube([5, 15, legLength+2]);
    translate([-5-5.75, -15/2, -1]) cube([5, 15, legLength+2]);
    
    translate([5.25/2, -2-0.2, -1]) cube([5, 10, legLength+2]);  //-0.2 is added to 
    translate([-5-5.25/2, -2-0.2, -1]) cube([5, 10, legLength+2]);//give room

}
