
exterior = 18;
interior_rodamiento = 8;
tornillo = 5;

difference() {
	union() {
		cylinder(r1=exterior/2,r2=exterior/2,h=2, center=true);
		translate([0,0,1]) cylinder(r1=interior_rodamiento/2,r2=interior_rodamiento/2,h=3, center=true);
	}
	cylinder(r1=tornillo/2,r2=tornillo/2,h=50, center=true);
}