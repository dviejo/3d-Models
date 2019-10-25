/**
 * tft24.scad
 * 
 * Created by Diego Viejo
 * 24/Oct/2019
 * 
 * Case for attaching a BigTreeTech TFT24 V1.1 display to a 60x20 profile
 * 
 */

Height = 60;
Width = 110;
Length = 20;

roundCorner = 5;

module case()
{
    difference()
    {
        hull()
        {
            translate([roundCorner/2, 0, 0]) cylinder(d=roundCorner, h=Length, $fn=20);
            translate([Width - roundCorner/2, 0, 0]) cylinder(d=roundCorner, h=Length, $fn=20);
            translate([roundCorner/2, Height - roundCorner/2, 0]) cylinder(d=roundCorner, h=Length, $fn=20);
            translate([Width - roundCorner/2, Height - roundCorner/2, 0]) cylinder(d=roundCorner, h=Length, $fn=20);
        }
        
        hull()
        {
            translate([roundCorner/2, 0, 2]) cylinder(d=roundCorner-2, h=Length, $fn=20);
            translate([Width - roundCorner/2, 0, 2]) cylinder(d=roundCorner-2, h=Length, $fn=20);
            translate([roundCorner/2, Height - roundCorner/2, 2]) cylinder(d=roundCorner-2, h=Length, $fn=20);
            translate([Width - roundCorner/2, Height - roundCorner/2, 2]) cylinder(d=roundCorner-2,     h=Length, $fn=20);
        }
    }
}

case();
