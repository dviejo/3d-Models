/**
 * config.scad
 * 
 * Constants and common methods used for the multi-copter
 * 
 */

//wire openning
wireDiameter = 8;


// suavizar las superficies curvas
//$fs= 1 ; 
//$fa= 1 ; 


///////////// armMount
entryWidth = 50.75/2;
entryHeight = 18.25/2;
entryDepth = 12;

outputWidth = 45/2; //49/2;
outputHeight = 18/2;
outputDepth = 8 +15; //For modelling, this is the position of the further ellipse


armLength = 184; //from the beginning of armMount/malePart to the center of motorMount

//auxiliary method
module oval(w,h, height, center = false) {
 scale([1, h/w, 1]) cylinder(h=height, r=w, center=center);
}


//auxiliary method
module nestedHull()
{
  for(i=[0:$children-2])
    hull()
    {
      children(i);
      children(i+1);
    }
}