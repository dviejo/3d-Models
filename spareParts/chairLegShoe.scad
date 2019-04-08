/**
 * Chair Leg's shoe
 * 
 * Created by Diego Viejo
 * 
 * This a replacement for a chair's leg with an internal diameter of 13.2mm. 
 * and external diameter of 16.5. Slice it ad 100% infill
 * 
 */

height = 15;

ID = 13.2 - 0.3;
OD = 16.5 + 1.5;
ODHeight = 3;

union()
{
    cylinder(d=OD, h=ODHeight);
    cylinder(d=ID, h=height, $fn=50);
}