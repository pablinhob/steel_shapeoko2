

difference() {
	linear_extrude(height = 10, center = false, convexity = 0)
       import (file = "z_axis_part2.dxf", layer = "0");
    holes();
}


module holes() {
	translate([0,3.9,6]) cube([18,12,12]);
	translate([24,3.9,6]) cube([18,12,12]);
	translate([0,24,6]) cube([18,12,12]);
	translate([24,24,6]) cube([18,12,12]);
	translate([55,20,8]) cylinder(h=10, r1=22/2, r2=22/2, center=true);


	translate([31.4, -3.7, 0]) cube([12,12,14], center=true);
	translate([31.4 , 43.4, 0]) cube([12,12,14], center=true );
	translate([78.6 , -3.7, 0]) cube([12,12,14], center=true);
	translate([78.6 , 43.4, 0]) cube([12,12,14], center=true);
}

