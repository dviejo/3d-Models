/**
 * WC Flush button
 * 
 * Created by dviejo
 * 19/01/2015
 * 
 */

externalRad = 17;
internalRad = 5.75;
connectionHole = 2.85;

height = 5;
beamHeight = 19;
connectionHoleDepth = 4;

module button()
{
  difference()
  {
    union()
    {
      difference()
      {
	cylinder(r=externalRad, h=height, $fn=50);
	translate([0, 0, 3]) cylinder(r=externalRad-1.5, h=height, $fn=50);
      }
      cylinder(r=internalRad, h=beamHeight);
    }
    translate([0, 0, beamHeight-connectionHoleDepth]) cylinder(r=connectionHole, h=connectionHoleDepth+1, $fn=15);
  }
}

button();