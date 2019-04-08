/*
 * Adapted toys - Juguetes adaptados
 * Puzzle #1
 * 
 * Created by DViejo
 * Date 5/Nov/2014
 * 
 * 
 */

height = 13;
width = 50;
length = 150;

holeRad = 7;
holeDepth = 7; //under the surface

beamHeight = 40;
beamRad = holeRad * 0.925;

module puzzleBase()
{
  hull()
  {
    cube([width, length, height/2]);
    
    translate([5, 0, height-5]) rotate([-90, 0, 0]) cylinder(r=5, h=length);
    translate([width-5, 0, height-5]) rotate([-90, 0, 0]) cylinder(r=5, h=length);
  }
}

module puzzleHoles()
{
  for(i = [0:5])
    translate([width/2, 40*i-25, height-holeDepth]) cylinder(r=holeRad, h=2*holeDepth);
}


module puzzle1()
{
  difference()
  {
    puzzleBase();
    puzzleHoles();
  }
}

module beam()
{
  cylinder(r=beamRad, h=beamHeight, $fn=50);
}

puzzle1(); 

for(i = [1:4])
    translate([width+10, 40*i-25, 0])
  beam();