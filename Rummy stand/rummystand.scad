/**
 * a rummy stand
 * Created by Diego Viejo
 * 08/Jun/2020
 * 
 */

use<Write.scad>

text = "Papa";

pieceLength = 38;
pieceWidth = 27;
pieceHeight = 3.25;

lateralHeight = 4;

Width = pieceWidth*10 + (lateralHeight+2)*2;
Length = 2*pieceLength + 3;
Height = pieceHeight; //for each layer

//translate([50, 0, ])
*difference()
{
    stand();
    
    translate([Width/2, pieceLength*3/2, -1]) mirror([0, 1, 0]) write(text,center=true, h=14, t=4,space=1);
}

lateral();

    dist = 12.2;
module stand()
difference()
{
    cube([Width, Length, 3*Height]);
    
    translate([-1, -1, Height*2]) cube([Width+2, 2*pieceLength+1, Height+1]);
    difference()
    {
        translate([-1, -1, Height]) cube([Width+2, pieceLength+1.3, Height+1]);
        
        translate([lateralHeight+0.5, -2, Height-1]) cube([1.5, pieceLength+3, Height+2]);
        translate([Width-lateralHeight-0.5-1.5, -2, Height-1]) cube([1.5, pieceLength+3, Height+2]);
    }
    
        //fancy cuts
    intersection()
    {
        difference()
        {
            translate([6, 4, -1]) cube([Width-12, Length-12, 12]);
            
            translate([-1, pieceLength-5, -2]) cube([Width, 10, 14]);
            
            hull()
            {
                translate([Width/2-22, pieceLength*3/2, -2]) cylinder(d=29, h=14, $fn=95);
                translate([Width/2+22, pieceLength*3/2, -2]) cylinder(d=29, h=14, $fn=95);
            }
        }
        
        for(i=[0:17]) for(j=[0:16])
        translate([10+(dist*3/2)*i+(dist*3/4)*(j%2),-7+(dist*3/7)*j, -1]) //rotate([-90, 0, 0]) 
            cylinder(d=dist*0.85, h=10, $fn=6);
    }
}

slope = 35;
module lateral()
difference()
{
    hull()
    {
        cylinder(d=13, h=lateralHeight, $fn=35);
        translate([40.5, 0, 0]) cylinder(d=13, h=lateralHeight, $fn=35);
        rotate(-slope-3) translate([2, Length, 0]) cylinder(d=13, h=lateralHeight, $fn=35);
    }

    hull()
    {
        translate([22.5, 3, -1])
            cylinder(d=6, h=lateralHeight+2, $fn=35);
        translate([36.5, 3, 0]) cylinder(d=6, h=lateralHeight+2, $fn=35);
        rotate(-slope-3) translate([14, Length-26, -1]) cylinder(d=6, h=lateralHeight+2, $fn=35);
    }

    *%translate([5, 0, 0]) rotate(180-slope) 
        translate([0, -Length, 20]) 
            rotate([0, 90, 0]) 
                scale(1.075) stand();
                
    translate([3.5, -1.5, -1]) 
        rotate(-slope)
        {
            cube([Height+0.7, Length+1.1, lateralHeight+2]);
            translate([-Height, Length-pieceLength*2, 0]) cube([2*Height+0.7, pieceLength+0.7, lateralHeight+2]);
            translate([-2*Height, 0, 0]) cube([3*Height+0.7, 4+0.7, lateralHeight+2]);
        }
}
