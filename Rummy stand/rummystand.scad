/**
 * a rummy stand
 * Created by Diego Viejo
 * 08/Jun/2020
 * 
 */

pieceLength = 30;
pieceWidth = 25;
pieceHeight = 2.5;

lateralHeight = 4;

Width = 40;//pieceWidth*10 + (lateralHeight+2)*2;
Length = 2*pieceLength;
Height = pieceHeight; //for each layer

stand();

//lateral();

module stand()
difference()
{
    cube([Width, Length, 3*Height]);
    
    translate([-1, -1, Height*2]) cube([Width+2, 2*pieceLength-3, Height+1]);
    difference()
    {
        translate([-1, -1, Height]) cube([Width+2, pieceLength-3, Height+1]);
        
        translate([lateralHeight+0.5, -2, Height-1]) cube([1.5, pieceLength, Height+2]);
        translate([Width-lateralHeight-0.5-1.5, -2, Height-1]) cube([1.5, pieceLength, Height+2]);
    }
}

slope = 15;
module lateral()
difference()
{
    hull()
    {
        cylinder(d=13, h=lateralHeight);
        translate([30, 0, 0]) cylinder(d=13, h=lateralHeight);
        rotate(-slope-3) translate([0, Length, 0]) cylinder(d=13, h=lateralHeight);
    }
    
    translate([5, 0, 0]) rotate(180-slope) 
        translate([0, -Length, 20]) 
            rotate([0, 90, 0]) 
                scale(1.075) stand();
}
