round = 0.1; // % de redondeo [0, 0.5]
$fn=100;

/**
 * La idea es hacer una caja con las esquinas redondeadas.
 * El tamaño de la caja viene marcado por w, l y h: ancho, largo y alto
 * El redondeo de las esquinas viene marcado por el parametro t
 * Si t no existe o es menor de cero, el redondeo es automatico al 10% del ancho/alto
 * Si t=0, no se redondean las esquinas
 * Si t>0, se tomará como el número de pixeles de redondeo
 */
module roundBox(w, l, h, t, center)
{
	half = w<l?w/2:l/2;
	if(t == 0)
	{
		cube([w, l, h], center);
	}
	else if(t<0)
	{
		roundBoxAuto(w, l, h, center);
	}
	else if(t>0 && t<half)
	{
		roundBoxT(w, l, h, t, center);
	}
	else {
		roundBoxAuto(w, l, h, center);
	}
}

module roundBoxT(w, l, h, t, center)
{
	rad = t;
	tt = 2*rad;
	if(center)
	{
		roundBoxTCenter(w=w, l=l, h=h);
	}
	else
	hull() {
		translate([rad, rad, 0])
		{
			cylinder(r = rad, h);
			translate([w-tt, 0, 0])
				cylinder(r = rad, h);
			translate([0, l-tt, 0])
				cylinder(r = rad, h);
			translate([w-tt, l-tt, 0])
				cylinder(r = rad, h);
		}
	}
}

module roundBoxTCenter(w, l, h, t)
{
	rad = t;
	tt = 2*rad;
	hull() {
		translate([(-w/2)+rad, (-l/2)+rad, -h/2])
		{
			cylinder(r = rad, h);
			translate([w-tt, 0, 0])
				cylinder(r = rad, h);
			translate([0, l-tt, 0])
				cylinder(r = rad, h);
			translate([w-tt, l-tt, 0])
				cylinder(r = rad, h);
		}
	}
}

module roundBoxAuto(w, l, h, center)
{
	rad = w<l?w * round:l*round;
	tt = 2*rad;
	if(center)
	{
		roundBoxAutoCenter(w=w, l=l, h=h);
	}
	else
	hull() {
		translate([rad, rad, 0])
		{
			cylinder(r = rad, h);
			translate([w-tt, 0, 0])
				cylinder(r = rad, h);
			translate([0, l-tt, 0])
				cylinder(r = rad, h);
			translate([w-tt, l-tt, 0])
				cylinder(r = rad, h);
		}
	}
}

module roundBoxAutoCenter(w, l, h)
{
	rad = w<l?w * round:l*round;
	tt = 2*rad;
	hull() {
		translate([(-w/2)+rad, (-l/2)+rad, -h/2])
		{
			cylinder(r = rad, h);
			translate([w-tt, 0, 0])
				cylinder(r = rad, h);
			translate([0, l-tt, 0])
				cylinder(r = rad, h);
			translate([w-tt, l-tt, 0])
				cylinder(r = rad, h);
		}
	}
}