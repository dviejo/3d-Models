/**
 * Parchis set
 * Juego de fichas y cubilete para parchis
 * 
 * Creado por Diego Viejo
 * 
 */


//Lista de parametros
fichaHeight = 1.1;
fichaRad = 15/2;

cubileteHeight = 45;
cubileteRad1 = 28/2;
cubileteRad2 = 29.5/2;
cubileteWall = 1;

module ficha()
{
  cylinder(r=fichaRad, h=fichaHeight, $fn=40);
}


module cubilete()
{
  difference()
  {
    chained_hull()
    {
      cylinder(r=cubileteRad1, h=2, $fn=40);
      translate([0, 0, cubileteHeight/2-4]) cylinder(r=cubileteRad2, h=8, $fn=40);
      translate([0, 0, cubileteHeight]) cylinder(r=cubileteRad1, h=1, $fn=40);
    }
    
    chained_hull()
    {
      translate([0, 0, 1]) cylinder(r=cubileteRad1-cubileteWall, h=1, $fn=40);
      translate([0, 0, cubileteHeight/2-4]) cylinder(r=cubileteRad2-cubileteWall, h=8, $fn=40);
      translate([0, 0, cubileteHeight]) cylinder(r=cubileteRad1-cubileteWall, h=2, $fn=40);
    }

  }
}

module chained_hull()
{
  for(i=[0:$children-2])
   hull()
   {
     children(i);
     children(i+1);
   }
}

cubilete();

for(i=[25, -25])
{
  for(j=[25, -25])
    translate([i, j, 0]) ficha();
}