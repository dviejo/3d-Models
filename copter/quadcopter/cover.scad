/**
 * cover.scad
 * quadcopter cover. It has to hold GPS module
 * 
 * Created by Diego Viejo on 09/Jun/2015
 * 
 */

include<config.scad>
include<../commons/config.scad>


module ellipsoid(w,h, center = false) {
 scale([1, h/w, 0.8]) sphere(r=w, $fn=60);
}

union()
{
    difference()
    {
        intersection()
        {
            ellipsoid(w = baseWidth, h=baseLength);
            translate([-200, -200, 0]) cube([400, 400, baseWidth*0.7]);
        }
    
        intersection()
        {
            ellipsoid(w = baseWidth-1, h=baseLength-1);
            translate([-200, -200, -1]) cube([400, 400, 1+(baseWidth-1)*0.7]);
        }
    }
    
    intersection()
    {
        difference()
        {
            translate([-107/2, -90/2, 0]) cube([107, 90, baseWidth*0.7]);
            translate([-97/2, -80/2, -1]) cube([97, 80, 2+baseWidth*0.7]);
            
            for(i=[1,-1]) 
            {
                for (j=[1,-1])
                {
                    translate([i*107/2, j*90/2, -1]) cylinder(r1=7, r2=0, h=10);
                }
                translate([i*40/2, -1-90/2, 4]) rotate([-90, 0, 0]) cylinder(r=1.65, h=2+90);
                translate([i*40/2, -1-90/2, 9]) rotate([-90, 0, 0]) cylinder(r=1.65, h=2+90);
            }
            
        }
        ellipsoid(w = baseWidth, h=baseLength);
    }
    
}




armRectification = -17;
translate([0, 0, -baseHeight])
{
//    import("../output/mainPlatformPart1.stl");
    import("../output/mainPlatformPart2.stl");
}

*translate([0, 10, 0])
for(i=[45, -45])
    rotate(i) translate([0,baseWidth+armRectification,-baseHeight/2]) import("../stl/copterArm.stl");
*translate([0, -10, 0])
for(i=[135, -135])
    rotate(i) translate([0,baseWidth+armRectification,-baseHeight/2]) import("../stl/copterArm.stl");
