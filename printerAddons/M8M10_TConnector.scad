/**
 * 
 * M8M10_TConnector.scad
 * 
 * Created by Diego Viejo
 * 
 * 14/April/2020
 * 
 */

 diam1 = 10;
 diam2 = 8;
 
difference()
{
    hull()
    {
        cylinder(d=diam1+8, h=diam2+4, $fn=60);
        translate([-diam1/2-0.5-diam2-3, -(diam1+8)/2 , 0]) cube([8, diam1+8, diam2+4]);
    }
    
    #translate([0, 0, -1]) cylinder(d=diam1+0.4, h = diam2+4+2, $fn=50);
    
    #translate([-diam1/2-0.5-diam2/2, -15, (diam2+4)/2]) rotate([-90, 360/24, 0]) cylinder(d=diam2+0.35, h=30, $fn=12);
    
    translate([-20, -(diam1-1)/2, -1]) cube([20, (diam1-1), diam2+4+2]);
}
