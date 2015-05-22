/**
 * copterArm.scad
 * 
 * Created by Diego Viejo
 * 19/May/2015
 * 
 */

include<config.scad>

use<motorMount.scad>

use<armMount.scad>

length = 184; //from the beginning of armMount/malePart to the center of motorMount

ESCLength = 90;
ESCStart = 32;
ESCHeight = 10;
ESCWidth = 27;

difference()
{
union()
{
    malePart();

    translate([0, length, 0]) rotate(-90) motorMount(action="add");

    rotate([-90,0,0])
    {
        hull()
        {
            translate([0, 0, entryDepth + outputDepth - 0.1])
                oval(w=outputWidth, h=outputHeight, height=0.1);

            translate([0, 0, length-44-20])
                oval(w=32/2+10*10/100, h=outputHeight, height=1);
        }
    
        for(i=[-10:0])
        {
            hull()
            {
                translate([0, 0, length-44+i*2])
                    oval(w=32/2+i*i/100, h=outputHeight, height=1);
                translate([0, 0, 140+(i+1)*2])
                    oval(w=32/2+(i+1)*(i+1)/100, h=outputHeight, height=1);
            }
        }
    
        for(i=[0:29])
        {
            hull()
            {
                translate([0, 0, length-44+i])
                    oval(w=32/2+i*i/100, h=outputHeight, height=1);
                translate([0, 0, length-44+i+1])
                    oval(w=32/2+(i+1)*(i+1)/100, h=outputHeight, height=1);
            }
        }
    
        nestedHull()
        {
            translate([0, 0, length-44+30])
                oval(w=32/2+30*30/100, h=outputHeight, height=1);
        
            translate([0, 0, length-1])
                oval(w=55/2, h=outputHeight, height=1);

            translate([0, 0, length]) rotate([-1, 0, 0]) translate([0, 0, 1/500+1]) 
                oval(w=56/2+1/2 , h=outputHeight, height=1);
        }
        translate([0, 0, length]) 
    
        //landing Gear
        difference()
        {
            ovalBlend();
            hull()
            {
                translate([0, 52.5, -5]) rotate([-90, 0, 0]) cylinder(d=17.5, h=30);
                translate([0, 52.5, 20]) rotate([-90, 0, 0]) cylinder(d=33, h=30);
            }
            difference()
            { 
                translate([0, 24, -15])  scale([1, 1.7, 1]) cylinder(d=50, h=60);
                translate([-40, -70, -30]) cube([80, 80, 45]);
            }
            hull()
            {
                translate([16, -8, 18]) rotate([-90, 0, 0]) cylinder(d=15, h=40);
                translate([19, -8, 38]) rotate([-90, 0, 0]) cylinder(d=15, h=25);

                translate([-16, -8, 18]) rotate([-90, 0, 0]) cylinder(d=15, h=40);
                translate([-19, -8, 38]) rotate([-90, 0, 0]) cylinder(d=15, h=25);
            }
        }
    }

} //end union
    //motor mount holes
    translate([0, length, 0]) rotate(-90) motorMount(action="remove");
    
    //main hole
    rotate([-90,0,0]) cylinder(d = wireDiameter, h=length);
    
    // zip ties
    rotate([-90,0,0])
    {
        translate([0, 0, outputDepth+2.5]) laze(w = outputWidth*0.8, h=outputHeight*0.8);

        translate([0, 0, length-56]) laze(w = (30/2+6*6/100)*0.8, h=outputHeight*0.8);

        translate([0, 0, length-28]) laze(w = (30/2+16*16/100)*0.8, h=outputHeight*0.8);
    }
    //ESC Holder
    rotate([-90,0,0]) translate([-ESCWidth/2, -ESCHeight/2, ESCStart]) cube([ESCWidth, ESCHeight, ESCLength]);
    
    //Uncomment next line to get part1
    //translate([0, -1, -90]) cube([100, length+30, 180]);
    //Uncomment next line to get part2
    mirror([1,0,0]) translate([0, -1, -90]) cube([100, length+30, 180]);
} //end difference


*color("red")
translate([0, 106.4, -36.3]) 
    rotate([0, 90, 0]) rotate(-90) 
        import("../stl/OpenRC_Quad_Alpha_Arm_Part_1.stl");

module ovalBlend(start=0, end=105)
{
    aux = end*end/100;
    change = 27;
    middle = (end-change)/2;
    for(i=[start:end])
    {
        hull()
        {
            rotate([-(i), 0, 0]) translate([0, 0, (i)*(i)/500 + i*0.55]) 
                oval(w=56/2 - (i-middle)*(i-middle)/150 +(middle)*(middle)/150, h=outputHeight+0.05*i, height=1);
            rotate([-(i+1), 0, 0]) translate([0, 0, (i+1)*(i+1)/500 + (i+1)*0.55]) 
                oval(w=56/2 - ((i+1)-middle)*((i+1)-middle)/150 +(middle)*(middle)/150, h=outputHeight+0.05*(i+1), height=1);
        }
    }
}

module laze(w=10, h=8, width=2.5)
{
    difference()
    {
        oval(w=w, h=h, height = width);
        translate([0, 0, -1]) oval(w=w-1.75, h=h-1.75, height = width+2);
        translate([-w-1, 0, -1]) cube([2*w+2, h+1, width+2]);
    }
    extra=2;
    difference()
    {
        translate([extra, 0, 0]) oval(w=w+extra, h=h, height = width);
        translate([extra, 0, -1]) oval(w=w+extra-1.75, h=h-1.75, height = width+2);
        translate([-w-1, -h-1, -1]) cube([3*w+2, h+1, width+2]);
        translate([w, -h, -1]) cube([3*w+2, 2*h+1, width+2]);
    }
    translate([w-1.75, 0, 0]) cube([1.75, 5, width]);
    
    translate([w-2.5, 3.65, -2]) rotate(-25) cube([10, 4, width+4]);
    
}

//laze();