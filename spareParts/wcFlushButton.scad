/**
 * WC Flush button
 * 
 * Created by dviejo
 * 19/01/2015
 * 
 */

externalRad = 16;
internalRad = 5.5;
connectionHole = 2.65;

height = 3;
beamHeight = 18;
connectionHoleDepth = 3;

module button()
{
  difference()
  {
    union()
    {
      cylinder(r=externalRad, h=height, $fn=50);
      cylinder(r=internalRad, h=beamHeight);
    }
    translate([0, 0, beamHeight-connectionHoleDepth]) cylinder(r=connectionHole, h=connectionHoleDepth+1, $fn=15);
  }
}

button();