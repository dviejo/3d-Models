/**
 * Pieza para cremallera
 * Diego Viejo
 * 16 Marzo 2013
 * 
 * Uses Write.scad from Harlan Martin - harlan@sutlog.com
 * You'll need to download it and locate it in the same folder or change the next use-sentence to link it correctly
 */
use<Write.scad>


//parameters
Text = "Custom Zip";
textHeight = 4;
height = 2.85;
ancho1 = 9;
ancho2 = 8;
pared = 1.65;
hueco = 7;
largo = 35;


rad = 1;

module cremalleraBlock()
{
  hull()
  {
    cylinder(r=rad, h=height);
    translate([ancho1, 0, 0]) cylinder(r=rad, h=height);
    translate([(ancho1-ancho2)/2, largo, 0]) cylinder(r=rad, h=height);
    translate([(ancho1-ancho2)/2+ancho2, largo, 0]) cylinder(r=rad, h=height);
  }
}

module cremalleraHoles()
{
  hull()
  {
    translate([(ancho1-ancho2)/2+pared, pared, -1]) cylinder(r=rad, h=height+2);
    translate([(ancho1-ancho2)/2+ancho2-pared, pared, -1]) cylinder(r=rad, h=height+2);
    translate([(ancho1-ancho2)/2+pared, hueco, -1]) cylinder(r=rad, h=height+2);
    translate([(ancho1-ancho2)/2+ancho2-pared, hueco, -1]) cylinder(r=rad, h=height+2);
  }
}

module cremallera()
{
  difference()
  {
    cremalleraBlock();
    cremalleraHoles();
  }
  translate([ancho1-0.5-(ancho2-textHeight)/2,10,height-1]) rotate([0, 0, 90])
    write(Text, h=textHeight, t=2,space=0.9);
}

cremallera();