use <MCAD/boxes.scad>


difference() {
	union() {
		roundedBox([39, 39, 30], 4, true);  
	}
	union() {
		cylinder(h = 100, r=9/2, center=true);
	}
}

