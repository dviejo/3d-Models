/**
 * cone1.scad
 * 
 * Cone for roller skating practice. Print it with elastic material.
 * 
 * Created by Diego Viejo
 * 23/May/2016
 * 
 */

Diam1 = 50;
Diam2 = Diam1*3/5;

Height = 50;
Wall=0.75;

Cone1();

module Cone1()
difference()
{
    cylinder(d1=Diam1, d2=Diam2, h=Height);
    
//    cylinder(d1=Diam1-2*Wall, d2=Diam2-2*Wall, h=Height);

}