/**
 * aluExtrLeg.scad
 * 20x20 perfil aluminio tipo I
 * 
 * Created by Diego Viejo 
 * 25/Feb/2015
 * 
 */

legWidth = 15;
legLength = 5;
legHeight = 5;

rotate([90, 0, 0])
difference()
{
    union()
    {
        cube([legWidth, legLength, legHeight]);
        translate([legWidth/2, 0, legHeight]) seta();
    }
    
    //bolt holes
*    translate([legWidth/2, legLength/4, -1]) cylinder(d=2.65, h=20);
*    translate([legWidth/2, legLength*3/4, -1]) cylinder(d=2.65, h=20);
*    translate([legWidth/2, legLength/4, -1]) cylinder(d=6.2, h=legHeight);
*    translate([legWidth/2, legLength*3/4, -1]) cylinder(d=6.2, h=legHeight);
}


module seta()
rotate([-90, 0, 0]) 
difference()
{
    cylinder(r=6.35, h=legLength);

    
    translate([5.725, -15/2, -1]) cube([5, 15, legLength+2]);
    translate([-5-5.725, -15/2, -1]) cube([5, 15, legLength+2]);
    
    translate([5.25/2, -2-0.2, -1]) cube([5, 10, legLength+2]);  //-0.2 is added to 
    translate([-5-5.25/2, -2-0.2, -1]) cube([5, 10, legLength+2]);//give room

    //translate([5.725, -5.725, -1]) 
    rotate(45)
        translate([-15/2, -15-5.75, -1]) cube([15, 15, legLength+2]);
    rotate(-45)
        translate([-15/2, -15-5.75, -1]) cube([15, 15, legLength+2]);
}
