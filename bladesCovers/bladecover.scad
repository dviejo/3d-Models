/**
 * bladecover.scad
 * 
 * created by Diego Viejo
 * 14/Feb/2017
 * 
 * This design is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This design is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this design; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 * 
 */

mainLength = 150;
mainWidth = 20;
bottomHeight = 14;
bladeWidth = 8;
wallWidth = (mainWidth - bladeWidth) / 2;
topHeight = 10;
totalHeight = bottomHeight + topHeight;
endDiam = totalHeight*2;

bladeCover();

translate([0, -15, 0])
bladeJoint();

module bladeCover()
{
    difference()
    {
        bladeCoverBody();
        bladeCoverHoles();
    }
}

module bladeCoverBody()
{
    *cube([mainLength, mainWidth, totalHeight]);
    *translate([mainLength, 0, totalHeight]) rotate([-90, 0, 0]) cylinder(d=endDiam, h=mainWidth);
    
    union()
    {
    hull()
    {
        translate([10/2, 0, 10/2]) rotate([-90, 0, 0]) cylinder(d=10, h=mainWidth);
        translate([10/2, 0, totalHeight - 10/2]) rotate([-90, 0, 0]) cylinder(d=10, h=mainWidth);
        
        translate([mainLength, 0, totalHeight/2 ]) rotate([-90, 0, 0]) cylinder(d=totalHeight, h=mainWidth);
        
    }
    
    hull()
    {
        translate([mainLength, 0, totalHeight/2+5 ]) rotate([-90, 0, 0]) 
            cylinder(d=totalHeight+10, h=mainWidth);
        translate([mainLength-10, 0, totalHeight/2 + 30 ]) rotate([-90, 0, 0]) cylinder(d=20, h=mainWidth);
        translate([mainLength-10, 0, 20/2 ]) rotate([-90, 0, 0]) cylinder(d=20, h=mainWidth);
    }
    }//end of union
}

module bladeCoverHoles()
{
    
    union()
    {
        hull()
        {
            translate([mainLength-totalHeight/3+5, (mainWidth-bladeWidth)/2, bottomHeight+totalHeight/3]) 
                rotate([-90, 0, 0]) 
                    cylinder(d=totalHeight*2/3, h=bladeWidth);
        
            translate([mainLength-totalHeight/3-30, (mainWidth-bladeWidth)/2, totalHeight*2]) 
                rotate([-90, 0, 0]) 
                    cylinder(d=totalHeight*2/3, h=bladeWidth);
        }
        hull()
        {
            translate([-1, (mainWidth-bladeWidth)/2, bottomHeight]) 
                cube([10, bladeWidth, topHeight+2]);
            translate([mainLength-totalHeight/3+5, (mainWidth-bladeWidth)/2, bottomHeight+totalHeight/3]) 
                rotate([-90, 0, 0]) 
                    cylinder(d=totalHeight*2/3, h=bladeWidth);
            
        }

    }
    
    for(i=[1:7])
    {
        translate([i*20, -1, (bottomHeight)/2]) rotate([-90, 0, 0]) cylinder(d=4, h=mainWidth+2, $fn=30 );
        translate([i*20, wallWidth, (bottomHeight)/2]) rotate([-90, 0, 0]) cylinder(d=6, h=bladeWidth);
    }
    for(i=[0, 1])
    translate([-1, i*mainWidth, (bottomHeight)/2]) hull()
    {
        sphere(d=7);
        translate([mainLength, 0, 0]) sphere(d=7);
    }
    
}


module bladeJoint()
difference()
{
    union()
    {
        rotate([0, 90, 0]) cylinder(d=5, h=4*20, $fn=30);

        cylinder(d=3.5, h=wallWidth+2+5/2-6/2, $fn=30);
        translate([0, 0, 5/2+wallWidth+1-6/2]) cylinder(d1=5, d2=2, h=bladeWidth/3, $fn=15);
        sphere(d=5, $fn=100);
        
        translate([4*20, 0, 0])
        {
            cylinder(d=3.5, h=wallWidth+2+5/2-6/2, $fn=30);
            translate([0, 0, 5/2+wallWidth+1-6/2]) cylinder(d1=5, d2=2, h=bladeWidth/3, $fn=15);
            sphere(d=5, $fn=100);
        }
    }
}