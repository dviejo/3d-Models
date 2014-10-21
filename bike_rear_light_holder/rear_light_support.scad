/**
 * 
 */

include<../roundBox.scad>

M3Nut_rad = 6.35 / 2;
M3Nut_height = 2.4;

outer_rad = 16;
inner_rad = 13;

height = 28;
width = 20;
length = 17;

//lower body
l_height = 3.5;

//upper body
u_width = 6.6;
u_length = 9;


//rotate([0, 180, 0])
//{
difference()
{
	union()
	{
		cylinder(r = outer_rad, h=height, $fn=100);
		intersection()
		{
			translate([-inner_rad, -5, height/2]) rotate([0, 90, 0]) cylinder(r=height/2, h=2*inner_rad);
			translate([-outer_rad, -2*outer_rad, -5]) cube([2*outer_rad, 2*outer_rad, height+10]);
		}
		intersection()
		{
			translate([2, -15, height/2]) rotate([0, 90, 0.1]) cylinder(r1 = 12, r2=4.5, h=inner_rad);
			translate([0, -5, height/2]) rotate([0, 90, 0]) cylinder(r=height/2, h=2*inner_rad);
		}
	}
	translate([0, 0, -1]) cylinder(r = inner_rad, h=height+2, $fn=100);
	translate([-width/2, -30, -1]) cube([width, 30, height+2]);
	translate([-3*inner_rad/2, -15, height/2]) rotate([0, 90, 0]) cylinder(r=1.65, h=3*inner_rad);
	translate([inner_rad, -15, height/2]) rotate([30, 0, 0]) rotate([0, 90, 0]) cylinder(r=M3Nut_rad, h=M3Nut_height, $fn=6);
}

//lower body
translate([-width/2, outer_rad-3, 0])
{
	difference()
	{
		union()
		{
			cube([width, length+3, l_height]);
			intersection()
			{
				translate([0, length+2.1, 1.0+l_height]) rotate([0, 90, 0]) cylinder(r=5, h=width+0, $fn=100);
				cube([width, length*3, l_height*6]);			
			}
		}
		translate([-1, length+2.1,1.0+l_height]) rotate([0, 90, 0]) cylinder(r=1.6, h=width+2, $fn=100);
		translate([-1, length+2.1, 1.0+l_height]) rotate([0, 90, 0]) cylinder(r=3.25, h=3, $fn=100);
		translate([width-M3Nut_height+0.1, length+2.1, 1.0+l_height]) rotate([30, 0, 0]) rotate([0, 90, 0]) cylinder(r=M3Nut_rad, h=M3Nut_height, $fn=6);
		translate([(width-9.5)/2, 14, -10]) cube([9.5, 15, 20]);
	}
}

//upper body
translate([-u_width/2, outer_rad-3, 0])
{
	difference()
	{
		union()
		{
			cube([u_width, u_length+3, height]);
			translate([0, u_length+3, height-8]) rotate([0, 90, 0]) cylinder(r = 8, h = u_width, $fn=100);
			intersection()
			{
				translate([-3.3, u_length+3, height-8]) rotate([0, 90, 0]) cylinder(r2=12, r1 = 5.55, h = 3.3+u_width, $fn=100);
				translate([-u_width, u_length+3, height-8]) rotate([0, 90, 0]) cylinder(r = 8, h = 2*u_width, $fn=100);
			}
		}
		translate([u_width-4.3, u_length+3, height-8]) rotate([0, 90, 0]) cylinder(r = 5.65, h = 4.4, $fn=100);
			translate([-3.4, u_length+3, height-8]) rotate([30, 0, 0]) rotate([0, 90, 0]) #cylinder(r = 4, h = 4.1, $fn=6);
			translate([-7, u_length+3-3.075, height-8+2.3]) rotate([0, 90, 0]) roundBox(w=4.6, l=6.15, h=15, t = 2.0);
	}
}
//}