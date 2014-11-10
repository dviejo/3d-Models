/**
 * Minimalistic single and dual extruder 
 * Derived from the direct extruder by Whosa whatsis
 * Created by DViejo
 */

filament_d = 3; //1.75;
spring_d = 10;

mainHeight = 14;
baseHeight = 6; //4.4;
offset = 3;
b623zzRad = 5;
b624zzRad = 6.5;
b623zzHeight = 4;
b624zzHeight = 5;

fan = 40;

trackerDiam1 = 10.56;
trackerDiam2 = 6.56;
trackerDiam = trackerDiam2;
correction = (trackerDiam1 - trackerDiam) / 2;

bearingRad = b623zzRad;
bearingHeight = b623zzHeight;

simple = 0;
prusaNozzle = 1; //for prusaNozzle and Budas
jHead = 2; //jor jHead 
E3D = 3;

AjusteNozzle = 1.25;

//for printing
//mirror([1, 0, 0]) //uncomment for reverse
//translate([-60, 0, 0]) 
//  simpleExtruder(nozzle=jHead, extra_width=6.5);
//for showing
//showSimpleExtruder();
newIdler();
mirror([1, 0, 0]) 
  translate([-30, -20, 0]) rotate(90)
    newIdler();
//printDualExtruder(n=E3D); //other options: jHead prusaNozzle

//showDualExtruder(nozzle=E3D);

//fanMount(nozzle=jHead);

module simpleExtruder(nozzle = prusaNozzle, extra_width=0)
{
	translate([20, 33, 0]) rotate(-90) 
	  newIdler();
	if(nozzle!=jHead)
	  base(nozzle=nozzle);
	else
	difference()
	{
	  translate([0, 15.5, 0]) base(nozzle=nozzle, alone=1, extra_width=extra_width);
	    #translate([trackerDiam/2 + AjusteNozzle, -35, baseHeight + mainHeight/2+offset]) 
	      rotate([0,90,0]) 
		rotate([-90,0,0]) 
		  wildseyed_mount_holes(insulator_d=16);
	  
	  //holes for the xcarriage
	  #translate([trackerDiam/2 + AjusteNozzle-(15+extra_width), -23, -25]) cylinder(r=1.8, h=52); 
	  translate([trackerDiam/2 + AjusteNozzle-(15+extra_width), -23, 2*baseHeight + mainHeight - 4]) cylinder(r=3.1, h=8); 
	  #translate([trackerDiam/2 + AjusteNozzle+(15+extra_width), -23, -25]) cylinder(r=1.8, h=52); 
	  translate([trackerDiam/2 + AjusteNozzle+(15+extra_width), -23, 2*baseHeight + mainHeight - 4]) cylinder(r=3.1, h=8); 
	}
}

module printDualExtruder(n=prusaNozzle, ufan=0)
{
  translate([-30, 40, 0]) 
    rotate(-30) 
      newIdler();
  translate([74, 40, 0]) 
    rotate(30) 
      mirror([1, 0, 0]) newIdler();
  dualExtruder(nozzle=n, usefan=ufan);
}

module showDualExtruder(nozzle = prusaNozzle, ufan=0)
{
  color("red")
  translate([45/2, -50, 0]) 
    rotate([0, 180, 0]) 
      import("x-carriageDual.stl");
  //nozzle plate
  if(nozzle == prusaNozzle)
    translate([45/2, -33.5, baseHeight+mainHeight/2+offset]) rotate([-90, 0, 0]) PrusaNozzlePlate(nozzle=2);
  if(nozzle == jHead)
  {
    translate([trackerDiam/2 + AjusteNozzle, -27, baseHeight + mainHeight/2+offset]) rotate([-90, 0, 0]) mkv();
    translate([45-(trackerDiam)/2 - AjusteNozzle, -27, baseHeight + mainHeight/2+offset]) rotate([-90, 0, 0]) mkv();
  }
  if(nozzle == E3D)
  {
    translate([trackerDiam/2 + AjusteNozzle, -27, baseHeight + mainHeight/2+offset]) rotate([-90, 0, 0]) e3DNozzle();
    translate([45-(trackerDiam)/2 - AjusteNozzle, -27, baseHeight + mainHeight/2+offset]) rotate([-90, 0, 0]) e3DNozzle();
  }
  //left idler
  translate([15.5, 15.5, idlerHeight]) {
    rotate(-3-correction*4) rotate([0, 180, 0]) newIdler();
  }
  //right idler
  translate([45-15.5, 15.5, idlerHeight]) 
    mirror([1, 0, 0]) 
      rotate(-3-correction*4) 
	rotate([0, 180, 0])
	  newIdler();
	  
  //left filament tracker
  %translate([0, 0, 8.25]) difference() {
	linear_extrude(height = 11, convexity = 5) difference() {
		circle(trackerDiam/2);
		circle(2.5);
	}
	translate([0, 0, 7.7]) rotate_extrude(convexity = 5, $fs = 0.5) translate([trackerDiam/2 + 1.3, 0, 0]) circle(r = 2);
  }
  //right filament tracker
  %translate([45, 0, 8.25]) difference() {
	linear_extrude(height = 11, convexity = 5) difference() {
		circle(trackerDiam/2);
		circle(2.5);
	}
	translate([0, 0, 7.7]) rotate_extrude(convexity = 5, $fs = 0.5) translate([trackerDiam/2 + 1.3, 0, 0]) circle(r = 2);
  }

  //fan
  %translate([22.5, -55, 30])
  {
    difference()
    {
      translate([-20, -20, 0])
      cube([40, 40, 7]);
      translate([0, 0, -1]) cylinder(r=19, h=9);
    }
  }
  
  dualExtruder(nozzle=nozzle, usefan=ufan);

}
 
posHole = sqrt(2048)/2;
     
module dualExtruder(nozzle=prusaNozzle, usefan = 0)
{
  difference()
  {
    union()
    {
      if(nozzle==jHead || nozzle == E3D)
      {
	translate([0, 15.5, 0]) base(nozzle=jHead);
	translate([45, 15.5, 0]) mirror([1, 0, 0]) base(nozzle=jHead);
      }
      else
      {
	translate([0, 15.5, 0]) base(nozzle=simple);
	translate([45, 15.5, 0]) mirror([1, 0, 0]) base(nozzle=simple);
      }
      translate([18, -16, 0]) cube([9, 15.5, baseHeight]);
      translate([18, -33.0, 0]) cube([9, 22.5, baseHeight*2 + mainHeight]);
      
      if(usefan!=0)
	translate([45/2, -fan-6, 0]) fanMount(nozzle);
      
      //joint for strengthen idlers
      translate([-41/2, 12, 0]) cube([82, 8, baseHeight]);
    }
    
    if(nozzle==prusaNozzle)
    {
      //Holes for attaching nozzle (Prusa's or Budas')
      #translate([45/2-25, -13, baseHeight + mainHeight/2+offset]) rotate([90, 0, 0]) cylinder(r=1.8, h=20);
      #translate([45/2+25, -13, baseHeight + mainHeight/2+offset]) rotate([90, 0, 0]) cylinder(r=1.8, h=20);
      #translate([45/2-25, -10, baseHeight + mainHeight/2+offset]) rotate([90, 0, 0]) cylinder(r=3.3, h=7);
      #translate([45/2+25, -10, baseHeight + mainHeight/2+offset]) rotate([90, 0, 0]) cylinder(r=3.3, h=7);
    }
    if(nozzle==jHead || nozzle == E3D)
    {
      //left extruder
      translate([trackerDiam/2 + AjusteNozzle, -28, baseHeight + mainHeight/2+offset]) 
	rotate([0,90,0]) 
	  rotate([90,0,0]) 
	    wildseyed_mount_holes(insulator_d=16);
      //right extruder
      translate([45-(trackerDiam)/2 - AjusteNozzle, -28, baseHeight + mainHeight/2+offset]) 
	rotate([0,90,0]) 
	  rotate([90,0,0]) 
	    wildseyed_mount_holes(insulator_d=16);
	    
      echo("-----------------------------------------------------------------------------------------------------------");
      echo("Nozzle Distance: ",(45-(trackerDiam)/2 - AjusteNozzle)-(trackerDiam/2 + AjusteNozzle));
      echo("-----------------------------------------------------------------------------------------------------------");
      
      translate([-correction-2, 0, -baseHeight])
      hull()
      {
	translate([-9, -24, 0]) cylinder(r=3, h = 50);
	translate([-30, -24, 0]) cylinder(r=3, h = 50);
	translate([-9, -40, 0]) cylinder(r=3, h = 50);
	translate([-30, -40, 0]) cylinder(r=3, h = 50);
      }
      translate([45 + correction + 2, 0, -baseHeight])
      hull()
      {
	translate([9, -24, 0]) cylinder(r=3, h = 50);
	translate([30, -24, 0]) cylinder(r=3, h = 50);
	translate([9, -40, 0]) cylinder(r=3, h = 50);
	translate([30, -40, 0]) cylinder(r=3, h = 50);
      }
    }
    
    //holes for the xcarriage
    translate([45/2-21.5, -24, -25]) cylinder(r=1.8, h=52); 
    translate([45/2+21.5, -24, -25]) cylinder(r=1.8, h=52); 
    //XCarriage mounting clearance
    translate([45/2-21.5, -24, baseHeight*2 + mainHeight + offset - 5.5 ]) cylinder(r=3.2, h=25); 
    translate([45/2+21.5, -24, baseHeight*2 + mainHeight + offset - 5.5 ]) cylinder(r=3.2, h=25); 

    //holes for the motors
    translate([15.5, -15.5, -1]) cylinder(r=3.15, h=6);
    translate([45-15.5, -15.5, -1]) cylinder(r=3.15, h=6);
    translate([-15.5, 15.5, -1]) cylinder(r=3.1 * 7/12, $fn = 6, h= 30);
    translate([15.5, 15.5, -1]) cylinder(r=3.1 * 7/12, $fn = 6, h= 30);
    translate([45-15.5, 15.5, -1]) cylinder(r=3.1 * 7/12, $fn = 6, h= 30);
    translate([45+15.5, 15.5, -1]) cylinder(r=3.1 * 7/12, $fn = 6, h= 30);
    //holes for clearing the space
    translate([0, -8, -1]) cube([45, 20, 10]);
    //translate([-7, 0, baseHeight]) cube([15, 25, 30]);
    //translate([37, 0, baseHeight]) cube([15, 25, 30]);
    //holes for mounting the fan
    *translate([45/2, -fan-5-posHole, baseHeight*2+mainHeight-5]) cylinder(r=1.5, h=6);
    *translate([45/2, -fan-5+posHole, baseHeight*2+mainHeight-5]) cylinder(r=1.5, h=6);
    
  }
}

rad1 = 16;
module fanMount(nozzle=prusaNozzle)
{
  difference()
  {
    union()
    {
	translate([0, 0, (baseHeight*2 + mainHeight)/2]) cube([50, 44, baseHeight*2 + mainHeight], center = true);
    }
    //nozzle clearing
    hull()
    {
      translate([15, -20, rad1+baseHeight]) rotate([-90, 0, 0]) cylinder(r=rad1, h=46);
      translate([30, -20, rad1+baseHeight-4]) rotate([-90, 0, 0]) cylinder(r=rad1, h=46);
    }
    hull()
    {
      translate([-15, -20, rad1+baseHeight]) rotate([-90, 0, 0]) cylinder(r=rad1, h=46);
      translate([-30, -20, rad1+baseHeight-4]) rotate([-90, 0, 0]) cylinder(r=rad1, h=46);
    }
    
    #translate([fan/2, -fan/2-3, -1]) cube([20, fan+6, mainHeight+15]);
    #translate([-20-fan/2, -fan/2-3, -1]) cube([20, fan+6, mainHeight+15]);

    //clearing prusaNozzle mounting plate
    if(nozzle==prusaNozzle)
      translate([-fan/2-5, 12, baseHeight-0.4]) cube([fan+10, 10, 50]);
    
    //fan
    translate([0, 0, baseHeight*2+mainHeight]) rotate(45)
    {
*      translate([0, -posHole, -5]) cylinder(r=1.5, h=16);
*      translate([0, posHole, -5]) cylinder(r=1.5, h=16);
*      translate([0, 0, 5]) cube([fan*2, fan*2, 10], center = true);
      //showing fan
      %translate([0, 0, 4]) 	
      difference()
      {
	intersection()
	{
	  rotate([0, 0, 0]) cube([fan, fan, 8], center=true);
	  cylinder(r=fan/2+6.5, h=10, center=true);
	}
	translate([0, 0, -5]) cylinder(r=fan/2-0.25, h=20);
      }
    }

  }
}


//TODO Check this extrudre: it's outdated!
module showSimpleExtruder()
{
  color("red")
  translate([0, -48, 0]) 
  rotate([0, 180, 0]) 
  import("x-carriageDual.stl");
  
  *translate([trackerDiam/2 + AjusteNozzle, -31.5, baseHeight+mainHeight/2]) rotate([-90, 0, 0]) PrusaNozzlePlate();
  *translate([0, 6.5, 9.65]) union() {
	rotate([0, 180, 0]) import("MP1703-MK7-Filament-Drive-Block-Back.stl", convexity = 5);
	import("MP1794-MK7-Filament-Drive-Block-Front.stl", convexity = 5);
  }
  
  
//  translate([0, 15.5, 0]) base();
  simpleExtruder(nozzle=jHead, extra_width=6.5);
  translate([15.5, 15.5, 0]) {
	*translate([-15.5, -15.5, 0]) translate([trackerDiam / 2 + 5 + filament_d, 0, 7.7]) linear_extrude(height = 4, convexity = 5) difference() {
		circle(5);
		circle(1.5, $fn = 6);
	}
	translate([0, 0, idlerHeight + 0.5]) rotate([0, 180, -9]) newIdler();
	//translate([0, 0, 0]) rotate(-9) newIdler();
  }
  *translate([0, 0, 2]) difference() {
	linear_extrude(height = 11, convexity = 5) difference() {
		circle(6.3);
		circle(2.5);
	}
	translate([0, 0, 7.7]) rotate_extrude(convexity = 5, $fs = 0.5) translate([5 + 2.5, 0, 0]) circle(r = 2);
  }
}

module support(h=5, r=5, n=1)
{
  for(i = [1:n])
  {
    translate([2*r*(i-1), 0, 0])
    {
      difference()
      {
	cylinder(r=r, h=h);
	translate([0, 0, -1]) cylinder(r=r-0.4, h=2+h);
      }
    }
  }
}


idlerHeight = mainHeight + 2* baseHeight - 1;
module newIdler()
{
  difference()
  {
    union()
    {
      cylinder(r=5, h=idlerHeight);
      translate([0, -15-correction, 0]) cylinder(r=5, h=idlerHeight);
      translate([-5, -15-correction, 0]) cube([10, 15.5+correction, idlerHeight]);
      rotate(-60) translate([-5, 0, 0]) cube([5, 37, idlerHeight]);
      rotate(-60) translate([-2.5, 37, 0]) {
	cylinder(r = 2.575, h = idlerHeight);
	rotate(30) {
		translate([-2.5, 0, 0]) cube([5, 7, idlerHeight]);
		translate([0, 7, 0]) cylinder(r = 2.5, h = idlerHeight);
	}
      }
      rotate(-30) translate([0, 0, 0]) cube([5, 10, idlerHeight]);
      cylinder(r=bearingRad+1.5, h=idlerHeight);
      
    }
    translate([-50, -93, mainHeight + baseHeight - 1]) cube([100, 100, 100]);
    
    //idler attaching hole
    rotate(-9) translate([15.5 - 10 - filament_d+2.5, -15.5, 0])
    {
      translate([0, 0, 5.3])
	cylinder(r = 2.5/2, h = 2);
      translate([0, 0, mainHeight/2 + offset + 2.25+0.35])
	cylinder(r = 3.2/2, h = 10);
      translate([0, 0, mainHeight/2 + offset + 4.5])
	cylinder(r = 3.2, h = 10);
      // idler bearing, for viewing
      %translate([0, 0, mainHeight/2 + offset -4.2/2])
	cylinder(r = 5, h = 4);
    }
    
    translate([0, 0, mainHeight/2 + offset]) {
	//idler bearing main hole
	translate ([-2, 0, 0]) rotate(-9) 
	  translate([15.5 - 10 - filament_d+2.5, -15.5, -5.5/2]) 
	    cylinder(r = 6.5, h = 5.2);
	//filament through hole
	hull()
	{
	  translate([12, 21, -1]) 
		rotate([90, 0, -6]) 
		  cylinder(r = 3, h = 27, $fn = 6);
	  translate([-3, -2, -1]) 
		rotate([90, 0, -12]) translate([15, 0, -15.5]) 
		  cylinder(r = 3, h = 20, center = true, $fn = 6);
	}
    }
          
      //spring holes
      #translate([0, 0, idlerHeight / 2 + offset + 3]) rotate([90, 0, 30]) translate([31, 0, -2]) cylinder(r = spring_d * 7/12, h = 13, $fn = 6);
      #translate([0, 0, idlerHeight / 2 + offset - 9]) rotate([90, 0, 30]) translate([31, 0, -2]) cylinder(r = spring_d * 7/12, h = 13, $fn = 6);
      
      //bearing holes
      translate([0, 0, -0.1]) cylinder(r=bearingRad+0.2, h=bearingHeight+1.1, $fn=30);
      translate([0, 0, baseHeight+mainHeight-bearingHeight - 0.5])
	cylinder(r=bearingRad+0.2, h=bearingHeight+0.3, $fn=30);
      
      //main screew hole
      #translate([0, 0, bearingHeight+1.2]) cylinder(r=3, h=40, $fn=15);
      
      //clearance for motor's frontal
      difference()
      {
	hull()
	{
	  translate([0, -15.5, -1]) cylinder(r=5.25, h=5+1);
	  translate([-5.25, -11, -1]) cube([5.25*2, 5.25*2, 5+1]);
	}
	translate([0, 0, -1]) cylinder(r=bearingRad+1.5, h=10);
      }

  }
  //support
  translate([0, -15-correction, 0]) support(h=5);
  #difference()
  {
    translate([0, -15-correction, 6.75]) support(h=5.7);
    translate([-10, -15-correction, 6.65]) cube([20, 5, 5.8]);
  }
  
}

module base(nozzle=prusaNozzle, alone=0, extra_width=0) 
{
  difference() {
	difference() {
		union() {
			translate([-15.5, 0, 0]) rotate(120) {
				translate([0, -5, 0]) cube([8, 10, baseHeight*2 + mainHeight]);
				translate([8, 0, 0]) cylinder(r=5, h=baseHeight*2 + mainHeight);
				translate([13, 0, 0]) rotate(-150 - 9 / 2) cube([15+5, 5+5, baseHeight*2 + mainHeight]);
			}
			hull()
			{
			  for (side = [1, -1]) translate([side * 15.5, 0, 0]) cylinder(r=5, h=baseHeight*2 + mainHeight);
			  for (side = [1, -1]) translate([side * 15.5, -39, 0]) cylinder(r=5, h=baseHeight*2 + mainHeight);
			}
			//adapter body
			if(nozzle==simple)
			hull() 
			{
			  translate([-15.5, -39, 0]) cylinder(r=5, h=baseHeight*2 + mainHeight);
			  translate([15.5 + AjusteNozzle, -39, 0]) cylinder(r=5, h=baseHeight*2 + mainHeight);
			}
			if(nozzle==prusaNozzle)
			{
			  hull() 
			  {
			    translate([-30+trackerDiam/2 + AjusteNozzle, -39, 0]) cylinder(r=5, h=baseHeight*2 + mainHeight);
			    translate([30+trackerDiam/2 + AjusteNozzle, -39, 0]) cylinder(r=5, h=baseHeight*2 + mainHeight);
			  }
			  
			  //fan
			  translate([-16, -39.5-32, 0]) cylinder(r=5, h=baseHeight*2 + mainHeight);
			  translate([16, -39.5-32, 0]) cylinder(r=5, h=baseHeight*2 + mainHeight);
						  
			}
			if(nozzle==jHead)
			{
			  if(alone==1)
			    difference()
			    {
			      hull() 
			      {
				  translate([-2, -46, 0]) cylinder(r=5, h=baseHeight*2 + mainHeight);
				  translate([15, -46, 0]) cylinder(r=5, h=baseHeight*2 + mainHeight);
				  translate([-2, -38, 0]) cylinder(r=5, h=baseHeight*2 + mainHeight);
				  translate([trackerDiam/2 + AjusteNozzle+15+extra_width, -38, 0]) cylinder(r=5, h=baseHeight*2 + mainHeight);
			      }
			      hull()
			      {
				translate([trackerDiam/2 + 17, -45, -1]) cylinder(r=2, h=baseHeight*2 + mainHeight+2);
				translate([trackerDiam/2 + 30, -45, -1]) cylinder(r=2, h=baseHeight*2 + mainHeight+2);
				translate([trackerDiam/2 + 17, -55, -1]) cylinder(r=2, h=baseHeight*2 + mainHeight+2);
				translate([trackerDiam/2 + 30, -55, -1]) cylinder(r=2, h=baseHeight*2 + mainHeight+2);
			      }
			    }
			  else
			    hull() 
			    {
			      translate([-15.5, -48, 0]) cylinder(r=5, h=baseHeight*2 + mainHeight);
			      translate([15.5 + AjusteNozzle, -48, 0]) cylinder(r=5, h=baseHeight*2 + mainHeight);
			    }
			}
		}
		for (side = [1, -1]) translate([side * 15.5, 0, -1]) cylinder(r = 3.1 * 7/12, $fn = 6, h=baseHeight*2 + mainHeight+2);
		
		difference()
		{
		  translate([0, -15.5, -1]) cylinder(r=12, h=baseHeight*2 + mainHeight+ 2);
		  //estos huecos son para hacer una guía que mejore la impresión con materiales flexibles
		  translate([trackerDiam/2 + AjusteNozzle, -29, baseHeight + mainHeight/2+offset]) rotate([-90, 0, 0]) cylinder(r1=12, r2=6.15/2, h=15.5-trackerDiam/2-2);
		}
	}
	difference()
	{
	    union()
	    {
		translate([-15.5, 0, -1]) rotate(30) translate([0, 5+correction*2, 0]) rotate(-60 - 9 / 2) translate([-15, 5, 0]) cube([60, 50, mainHeight + baseHeight*2+2]);
		translate([-7, -10, -1]) cube([100, 100, mainHeight + baseHeight*2+2]);
	    }
	    translate([-10, -20, -2]) cube([100, 25, baseHeight+2]);
	    //idler base      
	    *translate([15.5, 0, -2]) cylinder(r=3, h=2+baseHeight+offset-0.5);
			*translate([45-15.5, 15.5, 0]) cylinder(r=3, h=baseHeight+offset-0.5);

	}
	difference()
	{
	  translate([-50, -26, baseHeight]) cube([100, 20, mainHeight+baseHeight+1]);
	  translate([trackerDiam/2 + AjusteNozzle, -29, baseHeight + mainHeight/2+offset]) rotate([-90, 0, 0]) cylinder(r1=12, r2=5.8/2, h=15.5-trackerDiam/2-2);
	}
	//Springs
	#translate([-15.5, 0, baseHeight + mainHeight / 2+offset+3]) rotate([90, 0, 150 - 4.5]) translate([5, 0, 5.5+correction*1.25]) 
	  cylinder(r = spring_d * 7/12, h = 10, $fn = 6);
	#translate([-15.5, 0, baseHeight + mainHeight / 2+offset-9]) rotate([90, 0, 150 - 4.5]) translate([5, 0, 5.5+correction*1.25]) 
	  cylinder(r = spring_d * 7/12, h = 10, $fn = 6);

	//filament hole
	#translate([trackerDiam/2 + AjusteNozzle, -50, baseHeight + mainHeight/2+offset]) rotate([-90, 0, 0]) cylinder(r=1.85, h=100, $fn = 25);
	for (side = [1, -1]) 
	{
	  translate([side * 15.5, -31, 8]) cylinder(r=3.1 * 7/12, h=mainHeight+baseHeight+12);
	  translate([side * 15.5, -31, -1]) cylinder(r=3.1, h=8.7);
	}
	
	//prusanozzle adapter holes
	if(nozzle==prusaNozzle)
	{
	  #translate([-25+trackerDiam/2 + AjusteNozzle, -50, baseHeight + mainHeight/2+offset]) rotate([-90, 0, 0]) cylinder(r=1.75, h=25);
	  #translate([25+trackerDiam/2 + AjusteNozzle, -50, baseHeight + mainHeight/2+offset]) rotate([-90, 0, 0]) cylinder(r=1.75, h=25);
	  //Holes for prusai3 XCarriage
	  #translate([-15-extra_width, -39.5, -25]) cylinder(r=1.75, h=55); //those holes should be at -15 15 instead of -16 16
	  #translate([15+extra_width, -39.5, -25]) cylinder(r=1.75, h=55); //So, a modified XCarriage is needed
								//in this way, a 40x40 fan can be attached in the same holes
	  //holes for bottom fan
	  #translate([-16, -39.5-32, 15]) cylinder(r=1.75, h=15); 
	  #translate([16, -39.5-32, 15]) cylinder(r=1.75, h=15); 
	}
  }
    if(nozzle==prusaNozzle) difference()
  {
    hull() 
    {
      translate([-16, -39, 0]) cylinder(r=5, h=baseHeight*2+mainHeight);
      translate([16, -39, 0]) cylinder(r=5, h=baseHeight*2+mainHeight);
      translate([-16, -39.5-32, 0]) cylinder(r=5, h=baseHeight*2+mainHeight);
      translate([16, -39.5-32, 0]) cylinder(r=5, h=baseHeight*2+mainHeight);
    }
    translate([0, 0, baseHeight])
    hull() 
    {
      translate([-17, -39, 0]) cylinder(r=5, h=baseHeight*2+mainHeight);
      translate([17, -39, 0]) cylinder(r=5, h=baseHeight*2+mainHeight);
      translate([-17, -39.5-33, 0]) cylinder(r=5, h=baseHeight*2+mainHeight);
      translate([17, -39.5-33, 0]) cylinder(r=5, h=baseHeight*2+mainHeight);
    }
  }
			  	
}



module PrusaNozzlePlate(nozzle=1)
color("silver")
{
  difference()
  {
    hull()
    {
      translate([-20, 0 , 0]) cylinder(r=10, h=5);
      translate([20, 0 , 0]) cylinder(r=10, h=5);
    }
    translate([0, 0, -1]) cylinder(r=3, h=7);
    translate([-25, 0, -1]) cylinder(r=1.7, h=7);
    translate([25, 0, -1]) cylinder(r=1.7, h=7);
    if(nozzle==2)
    {
      translate([-16, 0, -1]) cylinder(r=3, h=7);
      translate([16, 0, -1]) cylinder(r=3, h=7);
    }
  }
  if(nozzle==1)
  {
    translate([0, 0, -45.5]) cylinder(r=3, h=45.5);
  }
  if(nozzle==2)
  {
    translate([-16, 0, -45.5]) cylinder(r=3, h=45.5);
    translate([16, 0, -45.5]) cylinder(r=3, h=45.5);
  }
}

wade_block_depth=28;
module wildseyed_mount_holes(insulator_d=12.7)  
{  
	extruder_recess_d=insulator_d+0.7;
	extruder_recess_h=10;

	// Recess in base
	translate([0,0,-1])
	cylinder(r=extruder_recess_d/2,h=extruder_recess_h+1);
	
	for (hole=[-1,1])
	  rotate(90,[1,0,0])
	    translate([hole*(extruder_recess_d/2-1.45),2.3+1.5,-wade_block_depth/2-1])
	      cylinder(r=1.5,h=wade_block_depth+2,$fn=10);
}

//mk-v data
mkv_rad = 8;
mkv_slot = 4.8; //distance from top to the beginning of the slot
mkv_slot_height = 4.6;
mkv_slot_rad = 6;
mkv_height = 40;

module mkv()
translate([0, 0, -mkv_height]){
	color("black")
	union()
	{
		cylinder(r=mkv_rad, h=mkv_height-mkv_slot-mkv_slot_height, $fn=100);
		translate([0, 0, mkv_height-mkv_slot-mkv_slot_height]) 
			cylinder(r=mkv_slot_rad, h = mkv_slot_height, $fn=100);
		translate([0, 0, mkv_height-mkv_slot]) 
			cylinder(r=mkv_rad, h=mkv_slot, $fn=100);
	}
	translate([-6, -12.7/2, -8.35]) cube([15.88, 12.7, 8.255]);
	translate([0, 0, -3.58 - 8.35]) cylinder(r2=8.128/2, r1=0.5, h=3.58);
}

e3DHeight = 50.1-12.3;
module e3DNozzle()
{
  mirror([0, 0, 1])
  {
    color("silver")
    {
      cylinder(r=8, h=3.7, $fn=100);
      translate([0, 0, 3.7])
	cylinder(r=6, h=5.6, $fn=100);
      translate([0, 0, 9.3])
	cylinder(r=8, h=3, $fn=100);
      translate([0, 0, 12.3])
	cylinder(r=4.5, h=50-12.3, $fn=100);
      translate([0, 0, 12.3+38/2])
	cylinder(r=7.5, h=(50-12.3)/2, $fn=100);
      translate([0, 0, 14.6])
	cylinder(r=8, h=1.2, $fn=100);
      for(i = [0:9])
      {
	translate([0, 0, 18.3+i*3.4])
	  cylinder(r=25/2, h=1.2, $fn=100);
      }
      translate([0, 0, 49])
	cylinder(r=1.4, h=4, $fn=100);
      translate([-10, -7.5, 52])
	cube([16, 16, 12]);
    }
    
    translate([0, 0, 63])
      cylinder(r=2.5, h=2, $fn=100);
    translate([0, 0, 65])
      cylinder(r=5, h=3, $fn=6);
    translate([0, 0, 68])
      cylinder(r1=2.5, r2 = 0.6, h=2, $fn=100);
  }
}