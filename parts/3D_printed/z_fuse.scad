
difference() {
	cube([55,50,11], center=true);
	buratos();
}


module buratos() {
	translate( [20,0,0] ) cylinder(h=40, r1=2.5, r2=2.5, center=true);
	translate( [-20,0,0] ) cylinder(h=40, r1=2.5, r2=2.5, center=true);

	translate( [-20,0,-3] ) cylinder( h=5, r1=12/2, r2=12/2, center=true);
	translate( [20,0,-3] ) cylinder( h=5, r1=12/2, r2=12/2, center=true);

	cylinder(h=40, r1=32/2, r2=32/2, center=true);
	rotate([90,0,0])cylinder(h=100, r1=10/2, r2=10/2, center=true);
}

