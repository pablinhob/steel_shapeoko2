module strings() {
  rotate([90,0,90]) {
  translate([0,0,0]) cylinder(r1 = 1,r2 = 1, h=20, $fn=10);
  translate([0,2,0]) cylinder(r1 = 1,r2 = 1, h=20, $fn=10);
  translate([0,4,0]) cylinder(r1 = 1,r2 = 1, h=20, $fn=10);
  translate([0,6,0]) cylinder(r1 = 1,r2 = 1, h=20, $fn=10);
  }
}


module bloque(){
	translate([1,0,-1.5])cube([30,8,9]);
	translate([20,-1,-1.5])cube([11,8,9]);
}

module holes() {
	translate([14,9,5-4.5/2])rotate([90,0,0])cylinder(r1=4.5/2,r2=4.5/2, h=11);
	translate([25,9,5-4.5/2])rotate([90,0,0])cylinder(r1=4.5/2,r2=4.5/2, h=11);
}

difference() {
	difference() {
		
		bloque();
		strings();
	}
	holes();
}
