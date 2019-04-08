/**
 * Adapted toys - Juguetes adaptados
 * 
 * Objetos simples
 * 
 * Created by DViejo
 * 05/Nov/2014
 * 
 */

side = 20;

cube(side);

translate([50, side/2, 0]) cylinder(r=side/2, h=side, $fn=70);