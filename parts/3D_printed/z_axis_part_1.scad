

difference() {
	linear_extrude(height = 10, center = false, convexity = 0)
       import (file = "z_axis_part1.dxf", layer = "0");
    holes();
}


module holes() {
	translate([0,3.9,6]) cube([18,12,12]);
	translate([24,3.9,6]) cube([18,12,12]);

	translate([0,24,6]) cube([18,12,12]);
	translate([24,24,6]) cube([18,12,12]);
}