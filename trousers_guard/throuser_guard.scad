/**
 * Trousers Guard - Salva pantalón
 * 
 * Created by DViejo
 * 
 */


rad1 = 72/2;
rad2 = 38/2;
rad3 = 63/2;
width = 4;
height = 8;
cube_edge = 25;

difference()
{
	hull()
	{
		cylinder(r = rad1, h = height, $fn=100);
		translate([rad1, 0, 0])
			cylinder(r = rad2, h = height, $fn=100);
		translate([rad1/2-width, 0, 0])
			cylinder(r = rad3, h = height, $fn=100);
	}

	hull()
	{
		translate([0,0,-height/2])
			cylinder(r = rad1-width, h = height*2, $fn=100);
		translate([rad1, 0, -height/2])
			#cylinder(r = rad2-width, h = height*2, $fn=100);
		translate([rad1/2-width, 0, 0])
			#cylinder(r = rad3-width, h = height, $fn=100);
	}
	translate([rad1+rad2, 0, height/2])
//		rotate([0,0,45])
			#cube([cube_edge, cube_edge, height*2], center = true);
}
