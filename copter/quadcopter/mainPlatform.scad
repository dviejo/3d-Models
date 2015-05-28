/**
 * MainPlatform for a quadcopter
 * 
 * Created by Diego Viejo
 * 28/May/2015
 * 
 */

include<config.scad>
include<../commons/config.scad>

use<../commons/armMount.scad>
use<../commons/copterArm.scad>

oval(w=baseWidth, h=baseLength, height=baseHeight);

