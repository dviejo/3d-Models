/**
 * WheelChair.scad
 * 
 * Created by Diego Viejo on 17/Dec/2020
 * 
 * Intended as a Mattel's Barbie complement
 * 
 */

Height = 6;
seatLength = 80;
seatWidth = 70;
seatHeight = 80;
slopeAngle = 20;

bigAxlePos = -20;
axleDist = 45;
bottom = -51;

module lateral()
difference()
{
    union()
    {
        %rotate(slopeAngle) cube([5, 80, Height]);
        
        hull()
        {
//            translate([0, -20, -Height/2]) cube([20, 5+20, Height]);
            translate([seatLength-Height/2, bottom-3, 0]) rotate([-90, 0, 0]) cylinder(d=Height, h=5-bottom+3, $fn=30);
            translate([-10, bottom-3, 0]) rotate([-90, 0, 0]) cylinder(d=Height, h=5-bottom+3, $fn=30);
        }
        
        translate([-5-5, 40+5 -Height/2, 0]) rotate([0, 90, 0]) cylinder(d=Height, h=seatLength+10-Height+3, $fn=30);
        translate([seatLength-Height/2, 0, 0]) rotate([-90, 0, 0]) cylinder(d=Height, h=40+2.5, $fn=30);
        translate([seatLength-Height/2, 40+2, 0]) sphere(d=Height, $fn=30);
        translate([-10, 0, 0]) rotate([-90, 0, 0]) cylinder(d=Height, h=40+2.5, $fn=30);
        translate([-10, 40+2, 0]) sphere(d=Height, $fn=30);
        
        //big wheel axle
        translate([-10, bigAxlePos, -Height/2]) cylinder(d=15, h=Height+1, $fn=30);
        
        //small wheel axle
        hull()
        {
            translate([seatLength-7, bigAxlePos-axleDist, -Height/2]) cylinder(d=12, h=Height, $fn=30);
            translate([seatLength-17, bottom -6/2, 0]) rotate([0, 90, 0]) cylinder(d=6, h=15, $fn=30);
        }
        translate([seatLength-7, bigAxlePos-axleDist, -Height/2]) cylinder(d=12, h=Height+1, $fn=30);
        
        //bottom
        translate([-20, bottom -6/2, 0]) rotate([0, 90, 0]) cylinder(d=6, h=seatLength+20-3, $fn=30);
        translate([seatLength-6/2, bottom-3, 0]) sphere(d=6, $fn=30);
        translate([-20, bottom-3, 0]) sphere(d=6, $fn=30);
        
        //leg
        translate([seatLength-3.5, 0, 0]) rotate(-90+slopeAngle+5) 
            rotate([0, 90, 0]) cylinder(d=6, h=75+3, $fn=30);
        hull()
        {
            translate([seatLength-Height-0.75, 0, 3]) rotate(slopeAngle+5) translate([0, -75, 0]) rotate([0, 90, 0]) cylinder(d=12, h=Height+2, $fn=20);
            translate([seatLength-3.5, 0, 0]) rotate(slopeAngle+5) translate([0, -75-3, 0]) sphere(d=Height, $fn=30);
            translate([seatLength-3.5, 0, 0]) rotate(slopeAngle+5) translate([0, -75+10, 0]) sphere(d=Height, $fn=30);
        }

    }
    
    //assembly holes
    translate([10, -10, -Height/2-1]) cylinder(d=3.5, h=Height+2, $fn=25);
    translate([10, -10, Height/2-3]) cylinder(d1=3, d2=7.5, h=3.5, $fn=25);
    translate([55, -10, -Height/2-1]) cylinder(d=3.5, h=Height+2, $fn=25);
    translate([55, -10, Height/2-3]) cylinder(d1=3, d2=7.5, h=3.5, $fn=25);
    
    //big wheel axle
    translate([-10, bigAxlePos, -Height/2-1]) cylinder(d=3, h=Height+5, $fn=20);
    //small wheel axle
    translate([seatLength-7, bigAxlePos-axleDist, -Height/2-1]) cylinder(d=3, h=Height+5, $fn=20);
    
    //under platform space
    hull()
    {
        translate([5, -20-15/2, -Height/2-5]) cylinder(d=15, h=Height+10, $fn=30);
        translate([seatLength-28, -20-20/2, -Height/2-5]) cylinder(d=20, h=Height+10, $fn=30);
        translate([-4, bottom+3, -Height/2-5]) cylinder(d=8, h=Height+10, $fn=30);
        translate([seatLength-25+(20-4)/2, bottom+1, -Height/2-5]) cylinder(d=4, h=Height+10, $fn=30);
    }
    
    //leg
    translate([seatLength-Height-0.75, 0, 3]) rotate(slopeAngle+5) 
        translate([-1, -75, 0]) 
            rotate([0, 90, 0]) cylinder(d=2.8, h=Height+2, $fn=20);
    translate([seatLength, 0, 0]) rotate(slopeAngle+5) translate([0, -72-3.75, -5])  cube([10, 20, 20]);

            
    //remove from the bottom to help printing
    translate([-100, -100, -10]) cube([300, 300, 10-Height/2+1]);
}


numRads = 9;
module bigWheel()
difference()
{
    cylinder(d=25+axleDist*2, h=Height, $fn=100);

    translate([0, 0, -1])
    difference()
    {
        cylinder(d=25+axleDist*2-Height*2, h=Height+2, $fn=50);
        
        {
            translate([0, 0, -1]) cylinder(d=17, h=Height+4, $fn=30);
            
            for(i=[0:numRads-1])
                rotate(i*360/numRads)
            translate([0, 0, Height/2]) rotate([-90, 0, 0]) cylinder(d=Height, h=(25+axleDist*2)/2 -2, $fn=30);
        }
    }
    
    //axle
    translate([0, 0, -1]) cylinder(d=3.65, h=Height+2, $fn=25);
}

module smallWheel()
difference()
{
    cylinder(d=25, h=5, $fn=50);
    //axle
    translate([0, 0, -1]) cylinder(d=3.65, h=Height+2, $fn=25);
}

footLength = 33;
module foot()
difference()
{
    hull()
    {
        cylinder(d=6, h=Height+2, $fn=35);
        translate([footLength, 0, 0]) cylinder(d=6, h=Height+2, $fn=35);
        translate([0, 15, 0]) cylinder(d=6, h=Height+2, $fn=35);
        translate([footLength, 15, 0]) cylinder(d=6, h=Height+2, $fn=35);
    }
    
    translate([footLength+3-4.75, -10, Height/2+1]) rotate([-90, 0, 0]) cylinder(d=3.5, h=50, $fn=25);
    
    translate([0, 0, -1])
    hull()
    {
        translate([footLength+3-7, 10, 0]) cylinder(d=10, h=Height+4, $fn=35);
        translate([footLength+3-7, 20, 0]) cylinder(d=10, h=Height+4, $fn=35);
        translate([footLength+7, 10, 0]) cylinder(d=10, h=Height+4, $fn=35);
    }
    
    translate([-5, -5 , Height]) cube([footLength-3.5, 25, 10]);
}

module chair()
difference()
{
    union()
    {
        translate([-10, -15+2.8/2, 0])
            cylinder(d=2.8, h=31, $fn=25);

        translate([0, 0, seatWidth/10]) rotate([0, 90, 0]) cylinder(d=seatWidth/5, h=seatLength-1.5*5, $fn=35);
        translate([0, 0, seatWidth-seatWidth/10]) rotate([0, 90, 0]) cylinder(d=seatWidth/5, h=seatLength-1.5*5, $fn=35);
        
        for(i=[0:5])
            translate([seatLength/12+i*(seatLength/6-1.5), -3, seatWidth/5-4])  cylinder(d=seatLength/6, h=seatWidth*2/3+4, $fn=35);
        
        translate([0, -15, 0]) cube([seatLength-1.5*5, 15, seatWidth]);
        
        rotate(slopeAngle)
        difference()
        {
            union()
            {
                translate([0, 0, seatWidth/10]) rotate([-90, 0, 0]) cylinder(d=seatWidth/5, h=seatHeight, $fn=35);
                translate([0, 0, seatWidth*9/10]) rotate([-90, 0, 0]) cylinder(d=seatWidth/5, h=seatHeight, $fn=35);
                for(i=[0:5])
                    translate([0, seatLength/12+i*seatLength/6, seatWidth/10]) scale([1, 1.5, 1]) cylinder(d=seatLength/6, h=seatWidth*2/3+7, $fn=55);
            }
            
            translate([-10, seatHeight, -10]) cube([100, 100, 100]);
            translate([-20, -10, -10]) cube([20, 100, 100]);
            
        }
    }
    
    //handles holes
    translate([-27, seatHeight-10, seatWidth/10]) rotate([0, 90, 0]) cylinder(d=3.5, h=5.5, $fn=25);
    translate([-27, seatHeight-10, seatWidth*9/10]) rotate([0, 90, 0]) cylinder(d=3.5, h=5.5, $fn=25);
    
    //assembly holes
    #translate([10, -10+seatLength/12-3, -30]) cylinder(d=2.8, h=120, $fn=25);
    #translate([55, -10+seatLength/12-3, -30]) cylinder(d=2.8, h=120, $fn=25);
    
    translate([-20, -20, -20]) cube([200, 6, 200]);
    translate([-20, -20, 15]) cube([15, 25, 1]);

}


*lateral();
//translate([0, -seatLength/12+3, -seatWidth-Height/2+1])
    chair()
*mirror([1, 0, 0]) lateral();

*translate([seatLength-7, bigAxlePos-axleDist, Height/2+1.5]) 
    smallWheel();
*translate([-10, bigAxlePos, Height/2+1.5]) 
    bigWheel();

//foot();
//translate([-20, 0, 0]) mirror([1, 0, 0]) foot();



