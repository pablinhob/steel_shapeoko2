

module base() {
  difference() {
    linear_extrude(height = 13, center = true, convexity = 10)
       import (file = "pulley_support.dxf", layer = "0");
    translate([2,-3,0]) cube([58,18,10]);
  }
}

module screw() {
  union() {
    translate([0,0,5])cylinder(r1=4/2,r2=4/2,h=16, center=true, $fn=10);
    cube([8,8,3], center= true);
  }
}

module screws() {


  translate([0,14,0])
    rotate([0,90,90])
      screw();

  translate([25,14,0])
    rotate([0,90,90])
      screw();

  translate([50,14,0])
    rotate([0,90,90])
      screw();

}

module top() {
  cube([35,4,13]);
}

module strings() {
  rotate([90,0,90]) {
  translate([0,0,0]) cylinder(r1 = 1,r2 = 1, h=100, $fn=10);
  translate([0,2,0]) cylinder(r1 = 1,r2 = 1, h=100, $fn=10);
  translate([0,4,0]) cylinder(r1 = 1,r2 = 1, h=100, $fn=10);
  translate([0,6,0]) cylinder(r1 = 1,r2 = 1, h=100, $fn=10);
  }
}

difference() {
  difference(){
    union() {
      base();
      translate([2,19.5,-6.5])top();
    }
    translate([6,0,0]) 
      screws();

  }
  translate([0,19,-3]) strings();
}