// Created from Nuevo_Code_Xcarriage - A.stl
// https://github.com/Mecan0/Code
// By J.Rodigo (www.jra.so)
// Licence Creative commons atribution & share alike.
// Modified by dviejo

include <config.scad>

//************************************//
// Parámetros de configuración global //
//************************************//

$fn = 100;

// Cojinetes Lineales
dCoLi = 15; //16.2 ;	// Diámetro

// Varillas lisas
dVaLi = 8.15 ; // Diámetro


//************************************//
//        Módulos de uso global       //
//************************************//

// Generar un hexágono circunscrito (Diámetro,altura) 
module hexagono(d,h){ 
	for (a = [0, 60,120]){ 
		rotate( a, [0, 0, 1])
		cube([d, d*tan(30), h], center = true);
	}
}

// Generar un cuadrado/chaflán a 45º (Arista,Altura,Giro{0 = 45º, 1 = 135º, ...}) 
module chamfer(a,h,g){ 
	rotate( g*90 + 45 , [0, 0, 1])
	cube([a, a, h]);
}


/**************************/
// Parámetros de la pieza  /
/**************************/

// Características de las tuerca
dTaTu = 3.3 ;	// Diámetro del taladro (3.3)
hCaTu = 5.5 ; 	// Distancia entre caras de la tuerca (5.5)

// Separador de los cojinetes lineales
// (Diámetro, Anchura , Distancia de corte {0 = media luna} )
module medialuna(d,h,w){
	difference(){
		// Cilindro
		rotate( 90, [0, 1, 0])
		cylinder(h = h, r = d/2);
		// Corte
		translate([-1, -d/2 - 1, -w])
		cube([h + 2, d + 2, d/2 + 1 + w]);
	}
}

// Soporte cilíndrico de los cojinetes lineales
module soportecojili(){
	// Separadores de los cojinetes
	translate([(mainWidth-58)/2, 0, 0])
	medialuna(dCoLi, 2, 6.1);
	
	translate([(mainWidth-3.6)/2, 0, 0])
	medialuna(dCoLi, 3.6, 6.1);
	
	translate([(mainWidth+58)/2-2, 0, 0])
	medialuna(dCoLi, 2, 6.1);
	
	difference(){
		union(){
			hull(){
				// Cilindro base
				rotate( 90, [0, 1, 0])
				cylinder(h = mainWidth, r = 11.1);
				// Aplanado lateral
				translate([0, -11.1, 0])
				cube([mainWidth, 11.1, 11.1]);
			}
		}
		union(){
			// Vaciado interior
			translate([-1, 0, 0])
			rotate( 90, [0, 1, 0])
			cylinder(h = mainWidth+2, r = dCoLi/2);
			// Corte a 60º
			translate([-1, 5.73, 0])
			rotate( 60 , [1, 0, 0])
			cube([mainWidth+2, 10, 10]);
			// Corte vertical
			translate([-1, -7.5, 0])
			cube([mainWidth+2, 10, 12]);
		}
	}
}

// Hueco para la sujeción de la brida
module brida(){
	difference(){
		// Rectangulo base
		translate([0, -10.462, -2])
		cube([11, 20.924, 4]);
		union(){
			// Vaciado cilíndrico
			translate([-3, 0, -3])
			cylinder(h = 6, r = 9.5);
			// Chaflanes
			translate([4, 11.16, -3])
			chamfer(11,6,3);
			translate([4, -11.16, -3])
			chamfer(11,6,3);
		}
	}
}

mainWidth = 80; //original: 58
linearBearingWidth = 26; //Gap for the bearing at the bottom


// Base rectangular con dos chaflanes
module baserec(){
	difference(){
		// Base + Chaflanes
		union(){
			// Pieza base
			cube([mainWidth, 52, 8]);
			soporteExtrusor();
		}
		// Operaciones
		union(){
			// Vaciado paso correa
			translate([mainWidth-10.5, 11.6-2, -2])
			  cube([10.5 + 1, 9.8, 12]);
			// Hueco de paso para la brida
			translate([mainWidth/2, 38, -1])
			  rotate( -90, [0, 1, 0])
			    brida();
			// Carril para el cojinete lineal inferior
			difference()
			{
			  translate([-1, 38, -4])
			    rotate( 90, [0, 1, 0])
			      cylinder(h = mainWidth+2, r = dCoLi/2);
			  // Separadores para el cojinete
			  translate([(mainWidth-linearBearingWidth)/2 - 2, 29, 1.2])
			    cube([2, 20, 6]);
			  translate([(mainWidth+linearBearingWidth)/2, 29, 1.2])
			    cube([2, 20, 6]);
			}
			// Chaflanes
			union(){
				translate([14, 52, -1])
				chamfer(20,10,1);
				translate([mainWidth-14, 52, -1])
				chamfer(20,10,3);
			}
		}
	}
}


alturaSoporte = 21.5;
extruderSeparation = 28;
module soporteExtrusor()
{
  difference()
  {
    translate([0, alturaSoporte, 0]) cube([mainWidth, 11.5, 41]);
        
    difference()
    {
	translate([mainWidth/2+headDist/2,alturaSoporte+1,extruderSeparation])mirror([1,0,0])rotate([90,180,0]) e3dMount();
	//Support. Remove after printing
	translate([mainWidth/2+headDist/2-8, alturaSoporte+1+e3dHeight1, 41-1]) 
	  cube([16, e3dHeight2,1]);
    }

    difference()
    {
      translate([mainWidth/2-headDist/2, alturaSoporte+1, extruderSeparation]) rotate([90, 180, 0]) e3dMount();
	translate([mainWidth/2-headDist/2-8, alturaSoporte+1+e3dHeight1, 41-1]) 
	  cube([16, e3dHeight2,1]);
    }
	
    for(i=[-1, 1])
    {
      //holes for attaching the extruder
      translate([mainWidth/2+i*mountingHoleSep, -1.5, extruderSeparation]) 
	rotate([-90, 0, 0]) 
	  cylinder(r=2.1, h=alturaSoporte*3);
    }
  }
}

// Soporte para la correa
module correa(){
	difference(){
		hull(){
			// Altura
			cube([3, 10, 14]);
			// Base
			cube([14, 10, 1]);
			// Chaflán
			translate([3, 0, 14])
			rotate( 135 , [0, 1, 0])
			cube([3, 10, 16]);
		}
		union(){
			// Muescas para las correas
			translate([0, 3, -1])
			cylinder(h = 16, r = 1.5);
			translate([0, 7, -1])
			cylinder(h = 16, r = 1.5);
		}
	}
}

// Unimos los diferentes módulos que forman la pieza
// Y aplicamos algunas operaciones comunes
module pieza(){
	difference(){
		union(){
			// Base rectangular preformada
			baserec();
			// Soporte cilíndrico preformado
			translate([mainWidth, -7.5, -4])
			  rotate( 180, [0, 0, 1])
			    soportecojili();
			// Soporte para la correa
			translate([mainWidth-8, 11.5 - 2, 5])
			  rotate( 180, [0, 0, 1])
			    rotate( 180, [1, 0, 0])
			      correa();
		}
		union(){
			// Alojamiento para la tuerca del soporte de la correa
			translate([mainWidth-18, 13.5 - 2, -8])
			cube([3, 6, 20]);
			// Cilindro pasador del soporte de los cojinetes
			translate([mainWidth/2, 5, -9])
			  rotate( 90, [1, 0, 0])
			    cylinder(h = 25, r = 1.5);
			// Cilindro pasador del tornillo de la correa
			translate([mainWidth-15+0.3, 16.5 - 2, 2]) rotate([0, 90, 0])
			  cylinder(h = 20, r = 3.6/2);
			translate([mainWidth-19, 16.5 - 2, 2]) rotate([0, 90, 0])
			  cylinder(h = 2, r = 3.6/2);
		}
	}
}

// Generamos la pieza!!

rotate([0, -90, 0]) //uncomment this for printing, comment for modeling
  pieza();	
