use <MCAD/boxes.scad>



module burato_tornillo( diametro_tornillo, diametro_arandela ) {

	cylinder(h=1000, r1=diametro_tornillo/2, r2=diametro_tornillo/2, center=true);
	cylinder(h=11, r1=diametro_arandela/2, r2=diametro_arandela/2, center=true);
	//cube([diametro_tuerca,diametro_tuerca,7], center = true);
}

difference() {
	union() {
		roundedBox([37, 37, 50], 4, true);  
	}
	union() {
		
		translate([0,16,9])	
			rotate([90,0,0])
				burato_tornillo(8,17);

		translate([11.1,10,25])	
			rotate([0,0,0])
				burato_tornillo(6,14);	
		translate([-11.1,-10,25])	
			rotate([0,0,0])
				burato_tornillo(6,14);		  
		translate([11.1,-10,25])	
			rotate([0,0,0])
				burato_tornillo(6,14);	
		translate([-11.1,10,25])	
			rotate([0,0,0])
				burato_tornillo(6,14);	
	}
}