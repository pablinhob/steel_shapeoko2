module peza() {
 difference(){
   difference() {
     cube([20,30+20,40], center=true);
     translate( [3,0,-20] )
         cylinder(r1=6,r2=6,h=101 );
       //cube([12,12,40], center=true);
   }
   union() {
     translate([-12,-16,0])
       rotate([0,90,0])
         cylinder(r1=7,r2=7,h=16 );
     translate([-14,-16,0])
       rotate([0,90,0])
         cylinder(r1=2.3,r2=2.3,h=300 );

     translate([-12,16,0])
       rotate([0,90,0])
         cylinder(r1=7,r2=7,h=16 );
     translate([-14,16,0])
       rotate([0,90,0])
         cylinder(r1=2.3,r2=2.3,h=300 );
    
   } 
 }
}


module diferencia() {
   difference() {
     translate([-9,0,0]) cube([20,30+20,40], center=true);
     translate( [3,0,-20] )
         cylinder(r1=12,r2=12,h=101 );
       //cube([12,12,40], center=true);
   }
}


rotate([0,90,0])
 difference() {
  peza();
  diferencia();
 }