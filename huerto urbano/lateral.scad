/**
 * lateral.scad
 * 
 * Creado por Diego Viejo
 * 24 de abril de 2020
 * 
 * Creando laterales para aumentar la capacidad de nuestro huerto urbano. Mejores y más ricas
 * hortalizas en camino :p
 * 
 */

length = 250;
width = 95;
height = 15;
wall = 2;

muescaPos = 180;  //desde la derecha
muescaLength = 20;
muescaWidth = 25;

sujeccion();

//lateral();


module sujeccion()
difference()
{
    union()
    {
        translate([-(15.5+3)/2, 0, 0]) cube([15.5+3, 110, 7]);
        translate([-(30+15.5+3)/2, 70.5-3/2, 0]) cube([30+15.5+3, 19+3, 7]);
    }
        translate([-15.5/2, -1, 1.5]) cube([15.5, 110+2, 6]);
        translate([-(30+15.5+3)/2-1, 70.5, 1.5]) cube([30+15.5+3+2, 19, 6]);
}

module lateral()
difference()
{
    cube([length, width, height]);
    
    //muesca 
    translate([length-muescaPos-muescaLength, -1, -1]) cube([muescaLength, muescaWidth+1, height+2]);
    translate([length-muescaPos-muescaLength, width-muescaWidth, -1]) cube([muescaLength, muescaWidth+1, height+2]);
    
    //operación bikini
    hull()
    {
        translate([12, muescaWidth+12, wall]) cylinder(d=6, h=1);
        translate([12, width- (muescaWidth+12), wall]) cylinder(d=6, h=1);
        translate([length-12, muescaWidth+12, wall]) cylinder(d=6, h=1);
        translate([length-12, width- (muescaWidth+12), wall]) cylinder(d=6, h=1);

        translate([6, muescaWidth+6, height]) cylinder(d=6, h=30);
        translate([6, width- (muescaWidth+6), height]) cylinder(d=6, h=30);
        translate([length-6, muescaWidth+6, height]) cylinder(d=6, h=30);
        translate([length-6, width- (muescaWidth+6), height]) cylinder(d=6, h=30);
    }
    hull()
    {
        translate([12, 12, wall]) cylinder(d=6, h=1);
        translate([12, width-12, wall]) cylinder(d=6, h=1);
        translate([length-muescaPos-muescaLength-12, 12, wall]) cylinder(d=6, h=1);
        translate([length-muescaPos-muescaLength-12, width-12, wall]) cylinder(d=6, h=1);

        translate([6, 6, height]) cylinder(d=6, h=30);
        translate([6, width-6, height]) cylinder(d=6, h=30);
        translate([length-muescaPos-muescaLength-6, 6, height]) cylinder(d=6, h=30);
        translate([length-muescaPos-muescaLength-6, width-6, height]) cylinder(d=6, h=30);
    }
    hull()
    {
        translate([length-12, 12, wall]) cylinder(d=6, h=1);
        translate([length-12, width- 12, wall]) cylinder(d=6, h=1);
        translate([length-muescaPos+12, 12, wall]) cylinder(d=6, h=1);
        translate([length-muescaPos+12, width-12, wall]) cylinder(d=6, h=1);

        translate([length-6, 6, height]) cylinder(d=6, h=30);
        translate([length-6, width-6, height]) cylinder(d=6, h=30);
        translate([length-muescaPos+6, 6, height]) cylinder(d=6, h=30);
        translate([length-muescaPos+6, width-6, height]) cylinder(d=6, h=30);
    }
}

