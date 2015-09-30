/**
 * 
 * Adapted toys - juguetes adaptados
 * 
 * Puzzle 2
 * 
 * Created by DViejo
 * 05/Nov/2014
 * 
 * TODO: include a handler for object pieces
 */

height = 8;
boardSide = 180;

objectHoleSide = 35;
objectGap= 8;

objectSide = objectHoleSide*0.95;
objectHeight = 15;

module puzzleBase()
{
  cube([boardSide, boardSide, height]);
}

module puzzleHoles()
{
  for(i = [0:3])
    for(j = [0:3])
      translate([objectGap+(objectGap+objectHoleSide)*i*2-(objectGap+objectHoleSide)*j, objectGap+(objectGap+objectHoleSide)*j, height/2])
      {
	piece1(objectHoleSide);
	translate([objectGap+objectHoleSide, 0, 0]) piece2(objectHoleSide);
      }
}

module puzzle2Board()
{
  difference()
  {
    puzzleBase();
    puzzleHoles();
  }
}


// cube piece
module piece1(side = objectSide)
{
    //cube side reduced to avoid the fitting of piece 2
    cube([side*0.9, side*0.9, objectHeight]);
}

// cylinder piece
module piece2(side = objectSide)
{
  translate([side/2, side/2, 0])
    cylinder(r=side/2, h=objectHeight);
}

module pieceSet()
{
  for(i = [0:1])
    for(j = [0:3])
      translate([objectGap+(objectGap+objectHoleSide)*i*2, objectGap+(objectGap+objectHoleSide)*j, height/2])
      {
	piece1();
	translate([objectGap+objectHoleSide, 0, 0]) piece2();
      }
}

//puzzle2Board();
pieceSet();