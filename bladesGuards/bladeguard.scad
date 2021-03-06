/**
 * bladeguard.scad
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
 * Uses Write.scad from Harlan Martin - harlan@sutlog.com
 * 
 */

use<Writescad/write.scad>

//Configurable parameters
mainLength = 155; //for a 10 2/3 inch blade ~= 271mm/2 = 135.5 + 19.5 = 155
                  //for a 10 inch blade  = 254mm/2 = 127 + 20 = 147
                  //for a 8 inch blade ~= 203mm/2 101.5 + 19.5 = 121
                  // 1 inch ~= 25.4 mm.
Text1 = "Blade Guard";
Text2 = "by D.Viejo";



mainWidth = 18;
bottomHeight = 11;
bladeWidth = 4.15;
wallWidth = (mainWidth - bladeWidth) / 2;
topHeight = 10;
totalHeight = bottomHeight + topHeight;
endDiam = totalHeight*2;

textHeight = 2;
textSize = 6;
charLength = textSize * 0.125 * 5.5;

bladeCover();

translate([0, -15, 0])
bladeJoint();
*translate([100, -15, 0])
bladeJoint();

*translate([0, 0, 1.5])
difference()
{
    rotate([0, 90, 0])
        cylinder(d=4, h=212, $fn=25);

    for(i=[0:12])
    {
        translate([(11+6.5)*i, 0, 0])
            hull()
            {
                translate([0, -10, 0]) sphere(d=6.5);
                translate([0, 10, 0]) sphere(d=6.5);
            }
    }
    translate([-1, -20, -20]) cube([212+2, 40, 20-1.5]); 
}
    


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
        translate([mainLength, 0, totalHeight/2+4 ]) rotate([-90, 0, 0]) 
            cylinder(d=totalHeight+8, h=mainWidth);
        translate([mainLength-5, 0, totalHeight/2 + 34 ]) rotate([-90, 0, 0]) cylinder(d=20, h=mainWidth);
        *translate([mainLength-8, 0, 20/2 ]) rotate([-90, 0, 0]) cylinder(d=20, h=mainWidth);
    }
    
    }//end of union
}

module bladeCoverHoles()
{
    
    union() //blade slot
    {
        hull()
        {
            translate([mainLength-totalHeight/3+5, (mainWidth-bladeWidth)/2-2, bottomHeight+totalHeight/3+4/2]) 
                rotate([-90, 0, 0]) 
                    cylinder(d=totalHeight*2/3+4, h=bladeWidth+4);
        
            translate([mainLength-totalHeight/3-6, (mainWidth-bladeWidth)/2-1, totalHeight*2+10]) 
                rotate([-90, 0, 0]) 
                    cylinder(d=totalHeight*2/3, h=bladeWidth+2);
            translate([mainLength-totalHeight/3-15, (mainWidth-bladeWidth)/2, bottomHeight+totalHeight/3]) 
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
        translate([i*20, wallWidth-1, (bottomHeight)/2]) rotate([-90, 0, 0]) cylinder(d=6, h=bladeWidth+2);
        
        if(i*20-6-topHeight*0.7>charLength*len(Text2))
        translate([i*20, 0, bottomHeight+topHeight*0.35]) 
            hull()
            {
                translate([6, 0, 0]) scale([1, 1, 1.3]) sphere(d=0.7*topHeight);
                translate([-6, 0, 0]) scale([1, 1, 1.3]) sphere(d=0.7*topHeight);
            }
        if(i*20-6-topHeight*0.7>charLength*len(Text1))
        translate([i*20, mainWidth, bottomHeight+topHeight*0.35]) 
            hull()
            {
                translate([6, 0, 0]) scale([1, 1, 1.3]) sphere(d=0.7*topHeight);
                translate([-6, 0, 0]) scale([1, 1, 1.3]) sphere(d=0.7*topHeight);
            }
    }
    for(i=[1:6])
    {
        translate([i*20+9, (mainWidth-bladeWidth)/2, -1]) cube([2, bladeWidth, bottomHeight+2]);
    }
    
    for(i=[0, 1])
    translate([-1, i*(mainWidth), (bottomHeight)/2]) hull()
    {
        sphere(d=6.5);
        translate([mainLength, 0, 0]) sphere(d=6.5);
    }
    
    
    translate([2.5, textHeight/2, bottomHeight]) rotate([0, 0, 0])
        rotate([90, 0, 0]) write(Text2, h=textSize, t=textHeight, font="knewave.dxf", space=1);

    translate([charLength * len(Text1) + 2.5, mainWidth-textHeight/2, bottomHeight]) rotate([0, 0, 0])
        rotate([-90, 180, 0]) write(Text1, h=textSize, t=textHeight, font="knewave.dxf", space=1);

    
}


module bladeJoint()
translate([0, 0, 1.5])
rotate([-90, 0, 0])
difference()
{
    union()
    {
        rotate([0, 90, 0]) cylinder(d=5, h=4*20, $fn=30);
        
        for(i=[0, 1])
        translate([4*20*i, 0, 0])
        {
            cylinder(d=3.5, h=wallWidth+0.2, $fn=30);
            translate([0, 0, wallWidth-1.5]) 
            {
                //cylinder(d1=6, d2=2.5, h=bladeWidth/3+2.5, $fn=25);
                sphere(d=6, $fn=25);
            }
            sphere(d=5, $fn=100);
        }

    }
    
    translate([-15, 1.5, -20]) cube([125, 20, 40]);
}