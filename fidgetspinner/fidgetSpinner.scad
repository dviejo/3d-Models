/**
 *
 * Fidget Spinner
 * 
 * created by Diego Viejo 
 * 
 * This spinner uses a 608 bearing in the center. For outer weights I'm using fridge magnets 17.5mm. diam, 5mm. height
 */

weightDiam = 17.5;
weightHeight = 5;

b608Diam = 22;
b608Height = 7;

nBlades = 3;

thick = 3.5;

bladeLength = 29;


difference()
{
union()
{
    difference()
    {
        translate([0, 0, -10/2])
            cylinder(d=bladeLength*2, h=10);
    
    
        translate([0, 0, -20]) cylinder(d=b608Diam+0.1, h=40);
    

        for(i=[0:nBlades])
        {
            //cuts
            hull()
            {
                rotate(i*360/nBlades + 180/nBlades)
                    translate([0, 36.5-nBlades, -20]) cylinder(d=360/(nBlades*nBlades), h=40);
                rotate(i*360/nBlades + 180/nBlades)
                    translate([0, 240, -20]) cylinder(d=300, h=40);
            }
        
            //wheight socket
            rotate(i*360/nBlades)
                translate([0, bladeLength, -20]) cylinder(d=weightDiam+0.1, h=40);
        }
    }

    difference()
    {
        for(i=[0:nBlades])
        {
            rotate(i*360/nBlades)
                translate([0, bladeLength, 0]) sphere(d=weightDiam+thick*2);
        }
    
        for(i=[0:nBlades])
        {
            rotate(i*360/nBlades)
            {
                translate([0, bladeLength, -7/2+1]) cylinder(d=weightDiam+0.1, h=40);
                translate([0, bladeLength, -7/2-1]) cylinder(d=weightDiam-3, h=40);
            }
        }
    }
}
    translate([-100, -100, -20-7/2]) cube([200, 200, 20]);
    translate([-100, -100, 7/2]) cube([200, 200, 20]);

}
