/**
 * 
 * Adapted toys - juguetes adaptados
 * 
 * Puzzle 2
 * 
 * Created by DViejo
 * 05/Nov/2014
 * 
 * Include a handler for object pieces
 */

//number of pieces in a row (pair number)
piecesNumber = 3;
objectHoleSide = 35;
objectGap= 7;

height = 8;
//boardSide = 180;
boardSide = piecesNumber * (objectHoleSide+objectGap) + objectGap;


objectSide = objectHoleSide*0.95;
objectHeight = 15;

gripDiam = 15;

module puzzleBase()
{
  cube([boardSide, boardSide, height]);
}

// module puzzleHoles()
// {
//   for(i = [0:piecesNumber-1])
//     for(j = [0:piecesNumber-1])
//       translate([objectGap+(objectGap+objectHoleSide)*i*2-(objectGap+objectHoleSide)*j, objectGap+(objectGap+objectHoleSide)*j, height/2])
//       {
// 	piece1(objectHoleSide);
// 	translate([objectGap+objectHoleSide, 0, 0]) piece2(objectHoleSide);
//       }
// }

module puzzleHoles()
{
  for(i = [0:piecesNumber-1])
    for(j = [0:piecesNumber-1])
      translate([objectGap+(objectGap+objectHoleSide)*i, objectGap+(objectGap+objectHoleSide)*j, height/2])
      {
	if(j%2==i%2)
	  piece1(objectHoleSide);
	else
	  piece2(objectHoleSide);
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
  for(i = [0:piecesNumber-1])
    for(j = [0:piecesNumber-1])
      translate([objectGap+(objectGap+objectHoleSide)*i, objectGap+(objectGap+objectHoleSide)*j, height/2])
      {
	if(j%2==i%2)
          difference()
          {
              piece1();
              translate([0.9*objectSide/2, 0.9*objectSide/2, -1])cylinder(d=gripDiam, h=objectHeight+2);
	  }
	else
	    difference()
        {
            piece2();
            translate([objectSide/2, objectSide/2, -1])cylinder(d=gripDiam, h=objectHeight+2);
        }      
      }
}

//puzzle2Board();
pieceSet();