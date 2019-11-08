use <MCAD/boxes.scad>



module burato_tornillo( diametro_tornillo, diametro_arandela ) {

	cylinder(h=1000, r1=diametro_tornillo/2, r2=diametro_tornillo/2, center=true);
	cylinder(h=11, r1=diametro_arandela/2, r2=diametro_arandela/2, center=true);
	//cube([diametro_tuerca,diametro_tuerca,7], center = true);
}

difference() {
	union() {
		roundedBox([37, 37, 14], 4, true);  
		translate([0,0,-9]) roundedBox([41, 41, 7], 4, true);  
	}

	translate([0,0,0]) cylinder(h=100, r1=12/2 , r2=12/2);

}