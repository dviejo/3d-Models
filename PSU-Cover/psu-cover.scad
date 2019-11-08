/**
 * psu-cover.scad
 * 
 * Created by Diego Viejo
 * 25/Oct/2019
 * 
 * Power Supply Cover with plug and switch combo and voltage display
 * 
 */

//case

Width = 118;
H1 = 55;
H2 = 45;
Height = H1+H2;
Length = 51;

Wall = 2;

// change this to true if your printer can place removable support (eg. PVA)
support = false;

//Adjustment. Check this to match your PSU 
AdjZ = H1 + 8;
AdjX = 14;
AdjDiam = 7;

//PSU connection
HoleZ = 32; //From H1
HoleY1 = 15;
HoleY2 = 40;

//plug combo

plugWidth = 49;
plugLength = 28;
plugFaceWidth = 60;
plugFaceLength = 50;
plugHoleDist = 5; //from plugFaceLength edges

//voltage display
vdWidth = 46.5;
vdLength = 27.5;
vdFaceWidth = 50;
vdFaceLength = 30.5;


module frame()
difference()
{
    hull()
    {
        translate([2, 2, 0]) cylinder(d=4, h=Height, $fn=20);
        translate([2, Length-2, 0]) cylinder(d=4, h=Height, $fn=20);
        translate([Width-2, 2, 0]) cylinder(d=4, h=Height, $fn=20);
        translate([Width-2, Length-2, 0]) cylinder(d=4, h=Height, $fn=20);
    }
    
    frameInner();
    if(support)
        translate([45, 25.5, -0.3]) comboPlug();
    else
        translate([45, 25.5, -Wall-0.3]) comboPlug();
    translate([Width+0.25, 19, 29]) voltageDisplay();
    
    //PSU connection
    for(i=[HoleY1, HoleY2])
    translate([-1, i, H1+HoleZ])
    hull()
    {
        translate([0, 0, -4.75/2]) rotate([0, 90, 0]) cylinder(d=4.75, h=120, $fn=20);
        translate([0, 0, 4.75/2]) rotate([0, 90, 0]) cylinder(d=4.75, h=120, $fn=20);
    }
    
    //bannana conectors
    translate([Width-8, Length-12, 10]) rotate([0, 90, 0]) cylinder(d=6.75, h=10);
    translate([Width-8, Length-12, 20]) rotate([0, 90, 0]) cylinder(d=6.75, h=10);
    translate([Width-8, Length-12, 35]) rotate([0, 90, 0]) cylinder(d=6.75, h=10);
    translate([Width-8, Length-12, 45]) rotate([0, 90, 0]) cylinder(d=6.75, h=10);
    
    //adjustmen HoleY1
    #translate([AdjX, -1, AdjZ]) rotate([-90, 0, 0]) cylinder(d=AdjDiam, h=10);
    
    // +
    translate([Width-1, Length-6.5, 15-6/2]) cube([2, 1.5, 6]);
    translate([Width-1, Length-6.5-6/2+1.5/2, 15-1.5/2]) cube([2, 6, 1.5]);
    // separation
    translate([Width-1, Length-15.5, 27.5-1.5/2]) cube([2, 12, 1.5]);
    // -
    translate([Width-1, Length-6.5, 40-6/2]) cube([2, 1.5, 6]);
}

module frameInner()
difference()
{
    union()
    {
        translate([3.5*Wall, 2*Wall, 2*Wall]) cube([Width-7*Wall, Length-3*Wall, Height]);
        translate([Wall, Wall, H1]) cube([Width-2*Wall, Length, Height]);
    }
    
    translate([2*Wall+1, 0, H1-0.1]) cube([2, Length-10, 20]);
    translate([Width-2*Wall-3, 0, H1-0.1]) cube([2, Length-10, 20]);
}

module comboPlug()
union ()
{
        hull()
        {
            translate([-plugFaceWidth/2, -plugLength/2, 0]) cube([plugFaceWidth, plugLength, Wall]);
            translate([0, plugFaceLength/2-0.5, 0]) cylinder(d=1, h=Wall);
            translate([0, -plugFaceLength/2+0.5, 0]) cylinder(d=1, h=Wall);
        }
        
        difference()
        {
            translate([-plugWidth/2-1, -plugLength/2, 0]) cube([plugWidth, plugLength, 15]);
            
            translate([-plugWidth/2-10, 0, 0]) rotate(45) cube([20,20,20]);
            translate([-plugWidth/2-10, -plugLength, 0]) rotate(45) cube([20,20,20]);
        }
    
        translate([0, plugFaceLength/2-plugHoleDist, 0]) cylinder(d=2.7, h=20);
        translate([0, -plugFaceLength/2+plugHoleDist, 0]) cylinder(d=2.7, h=20);
}

module voltageDisplay()
rotate([0, -90, 0])
union()
{
    translate([-vdWidth/2, -vdLength/2, 0]) cube([vdWidth, vdLength, 15]);
    translate([-vdFaceWidth/2, -vdFaceLength/2, 0]) cube([vdFaceWidth, vdFaceLength, Wall+1]);
    translate([-vdFaceWidth/2, -vdFaceLength/2, 4.25]) cube([vdFaceWidth, vdFaceLength, 6]);

}

frame();
