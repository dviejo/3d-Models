/**
 * plankHolder.scad
 * 
 * This is a piece designed to hold a woden plank to a aluminium beam (20x20 I-type)
 * 
 * Created by Diego Viejo
 * 29/Jan/2016
 */

height = 4;
side = 20;

hypo = sqrt(side*side+side*side);

module plankHolderBase()
union()
{
    cube(side);
    cube([side*2, height, side]);
}


module plankHolderHoles()
{
    translate([0, hypo*sin(45)+height, -1])
        rotate(-45)
            cube([hypo, side, side+2]);
            
    //bolt for the beam
    translate([-1, side/2, side/2])
        rotate([0, 90, 0])
            cylinder(d=4.5, h=side);
    translate([2.5, side/2, side/2])
        rotate([0, 90, 0])
            cylinder(d=8, h=side);
    
    //bolts for the plank
    translate([2*side-side/3, -1, side/2])
        rotate([-90, 0, 0])
            cylinder(d=3.5, h=height+2);
    translate([side-side/6, -1, side/2])
        rotate([-90, 0, 0])
            cylinder(d=3.5, h=side);
    translate([side-side/6, height, side/2])
        rotate([-90, 0, 0])
            cylinder(d=7, h=side);
    translate([2*side-side/3, height-1.5, side/2])
        rotate([-90, 0, 0])
            cylinder(d1=3.5, d2=7, h=2);
    translate([side-side/6, height-1.5, side/2])
        rotate([-90, 0, 0])
            cylinder(d1=3.5, d2=7, h=2);
}


module plankHolder()
difference()
{
    plankHolderBase();
    plankHolderHoles();
}

plankHolder();