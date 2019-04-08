/**
 * TableBuild.scad
 * 
 * Parts for building a desktop from a couble of wooden tables
 * 
 * Created by DViejo
 * 12/May/2015
 * 
 */

// suavizar las superficies curvas
$fs= .1 ; 
$fa= .1 ; 



tableWidth = 19; //width of your tables

height = 140;
width = 120;
depth = 200;

wallthick = 12;

module oval(w,h, height, center = false) {
 scale([1, h/w, 1]) cylinder(h=height, r=w, center=center);
}


module arc()
difference()
{
    oval(w=width, h = height, height = wallthick);
    
    translate([0, 0, -1]) oval(w=width-tableWidth, h = height-tableWidth, height = wallthick+2);
    translate([-width-1, -height-1, -1]) cube([2*width+2, height+1, wallthick+2]);
    
    translate([0, -1, -1]) cube([width+1, height+2, wallthick+2]);
}

arc();
translate([depth - tableWidth, 0, 0])  arc();
translate([-width, -tableWidth, 0]) cube([depth, tableWidth, wallthick]);
translate([0, height-tableWidth, 0]) cube([depth-20, tableWidth, wallthick]);
