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
    cube(side+wall*2);
    
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