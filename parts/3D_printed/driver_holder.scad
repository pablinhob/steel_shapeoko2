module pieza_base() {

  difference(){
		cube([40,9,7]);
		translate([2,0,0])cube([34.5,5,4]);
	};
}

module peza() {
  rotate([0,180,0]){
    difference(){
      pieza_base();
      union(){
        translate([4,0,0]) cube([18,5,8]);
        translate([0,6,0]) cube([22,5,8]);
      }
    }
  }
}



peza();

translate([0,-5,0])
  mirror([0,1,0]){
    peza();
  }