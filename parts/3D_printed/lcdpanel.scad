// yet another LCD panel case.  This one is for the GEEETech, which I think is pretty much the same as the RepRapDiscount one.
// this is intended to be used with a complementary rear mount of some kind.
//
// John Ridley October 24 2013 
// 	Prusa i3 single plate versión modified by Pablo Blanco 2014


prusai3_frame_width = 10.5;

boxix = 155; 
boxiy = 67;
boxiz = 20;

dispx = 99;
dispy = 41;
dispxoff = 14.5;
dispyoff = 14.5;
disptaper = 2; // 2mm taper on each side

controld = 10;
controlxoff = 138;
controlyoff = 32.5;
buzzyoff = 13;

buttond = 10;
buttonxoff = 138;
buttonyoff = 49;
buttonht = 8.5;

mountx = 145;
mounty = 50;
mountxoff = 5; 
mountyoff = 5;
mountpillard = 7;
mountholed = 2.95;
mountht = 12;

// the mounting bracket stuff
screwheadd = 9;
screwholed = 4.2;
woodscrewd = 4.2;
woodscrewh = 7;
woodscrewhh = 2;
hingelength = 50;
mountmainlength = 35;
mounthingelength = 15;
// put the mount near the controls for stability
// that's where people will be poking at the thing.
mountoffset = 40;

sdy = 30;
sdz = boxiz - mountht;
sdyoff = 20;
sdht = 4;

cornerr = 3;
wall = 3;

// knob dimensions
ctlid = 6.3;
ctldd = 5; // dimension across d flat
ctlod = 9;
ctlht = 5;
knobd = 25;
knobh = 15;


$fn = 20;




// this is the panel cover
if (1)
{
	// flip over for printing
	translate([0,0,boxiz+wall])
	rotate([180,0,0])

	difference()
	{
		boxsolids();
		boxvoids();
	}
}

// this is the mounting hinge - make two, use a 6-32 x 3" screw
if (0)
{
	rotate([90,0,0])
	difference()
	{
		union()
		{
			frame_support(mounthingelength);
			cube([mounthingelength, wall, hingelength]);
		}
		for (z=[0,1])
		translate([mounthingelength/2,wall+0.01,screwheadd*2 + z*(hingelength-screwheadd*3)])
		rotate([90,0,0])
		woodscrewhole(woodscrewd, woodscrewh, woodscrewhh, wall+0.1);
	}
}

// this is the knob
if (0)
{
	difference()
	{
		knobsolids();
		knobvoids();
	}
}

ctlid = 6.3;
ctldd = 5; // dimension across d flat
ctlod = 12;
ctlht = 5;
knobd = 25;
knobh = 10;
knobtaper = 2;

module knobsolids()
{
	hull()
	{
		cylinder(r=(knobd-knobtaper*2)/2, h=0.01);
		translate([0,0,knobtaper])
			cylinder(r=knobd/2, h=knobh-knobtaper);
	}
}

module knobvoids()
{
	// hollow out most of the interior
	translate([0,0,6])
	{
	difference()
	{
		cylinder(r=knobd/2-4, h=knobh);
		cylinder(r=ctlod/2, h=knobh);
	}

	// shaft hole
//	translate([0,0,5])
	difference()
	{
		cylinder(r=ctlid/2, h=knobh);
		// this is one way to make the key
		translate([0, (ctlid-ctldd+1.5),0])
			cylinder(r=1.5, h=knobh);
		// this is another = 
//		translate([-ctlid/2,ctlid-ctldd,0])
//			cube([ctlid, ctlid, knobh]);
	}
	// cutouts for flat springy bit
	// only use if needed - it weakens the part
//	for (x1=[-1,1])
//	translate([-0.5 + x1*2.5,ctlid-ctldd,0])
//		cube([1,5,knobh]);
	}

	// some knurling
	for (a=[0:9])
	rotate([0,0,a*360/10])
	translate([3+knobd/2,0,0])
	cylinder(r=4,h=knobh);
}

module woodscrewhole(screwd, headd, headh, wallthick)
{
	cylinder(r=screwd/2, h=wallthick);
	cylinder(r1=headd/2, r2=screwd/2, h=headh);
}


module boxvoids()
{

	if (0) // actually don't bevel since we're inset
	{
		// let's bevel the display edges
	// display cutout
	translate([-boxix/2 + dispxoff, -dispy+boxiy/2-dispyoff, boxiz])
		union()
		{
			hull()
			{
				translate([-disptaper, -disptaper, wall])
					cube([dispx+disptaper*2, dispy+disptaper*2, 0.1]);
				translate([0,0,wall*1/3])
					cube([dispx, dispy, 0.1]);
			}
			cube([dispx, dispy, wall]);
		}
	}
	if (1) // untapered display cutout
	{
	// display cutout
	translate([-boxix/2 + dispxoff, -dispy+boxiy/2-dispyoff, boxiz])
		cube([dispx, dispy, wall]);
	}

	// control cutout
	translate([-boxix/2+controlxoff,boxiy/2-controlyoff,0])
		cylinder(r=controld/2, h=boxiz+wall);

	// speaker cutout
	translate([-boxix/2 + controlxoff,boxiy/2 - buzzyoff,0])
	intersection()
	{
		cylinder(r=6, h=boxiz+wall);
		translate([-6,0,0])
			for (iy=[-1:1])
				translate([0,iy*3-1,0])
					cube([12,1.5,boxiz+wall]);
	}

	// sd card hole
	translate([-boxix/2-wall,boxiy/2-sdy - sdyoff,0])
		cube([wall*10, sdy, sdz]);

	// reset button
	translate([-boxix/2 + buttonxoff, boxiy/2-buttonyoff, boxiz-wall])
		button_cutout();

	// taper the bottom
	translate([0,0,boxiz+wall-disptaper])
	difference()
	{
		roundedbox(boxix+wall*2, boxiy+wall*2, disptaper, cornerr);
		hull()
		{
			roundedbox(boxix+wall*2, boxiy+wall*2, 0.1, cornerr);
translate([0,0,disptaper])
//			translate([-disptaper, -disptaper, disptaper])
				roundedbox(boxix+wall*2-disptaper*2, boxiy+wall*2-disptaper*2, 0.1, cornerr);
		}
	}
}

module boxsolids()
{
	// the main box
	difference()
	{
		roundedbox(boxix+wall*2, boxiy+wall*2, boxiz+wall, cornerr);
		roundedbox(boxix, boxiy, boxiz, cornerr);
	}

	// mount pillars
	for (ix=[0,1])
	for (iy=[0,1])
	translate([-boxix/2+mountxoff + mountx*ix,boxiy/2-mountyoff - mounty*iy,boxiz - mountht])
	difference()
	{
		cylinder(r=mountpillard/2, h=mountht);
		cylinder(r=mountholed/2, h=mountht);
	}

	// button pokey bit
	translate([-boxix/2 + buttonxoff, boxiy/2-buttonyoff, boxiz-buttonht])
		// the tiny hole in the center makes your slicer use a lot more infill for a sturdy button.
		difference()
		{
			cylinder(r=buttond/2*0.6, h=buttonht);
			cylinder(r=0.5, h=buttonht);
		}

	rotate([0,0,180])
	translate([ - mountx/2, 34, 3])
		frame_support(mountx, mounty);
}

module roundedbox(x,y,z,rad)
{
	hull()
	for (ix=[-1,1])
	for (iy=[-1,1])
	{
		translate([(x/2-rad)*ix, (y/2-rad)*iy,0])
			cylinder(r=rad, h=z);
	}
}


module button_cutout()
{
	minkowski()
	{
		difference()
		{
			union()
			{
				cylinder(r=buttond/2, h=wall);
				translate([-(buttond*0.6)/2,-(buttond*1.3),0])
					cube([buttond*0.6,buttond,wall]);
				translate([-buttond*1.5+(buttond*0.6)/2,-(buttond*1.3),0])
					cube([buttond*1.5,buttond*0.6,wall]);
			}
			// same but slightly tinier
			union()
			{
				cylinder(r=buttond/2-0.1, h=wall);
				translate([-(buttond*0.6)/2+0.05,-(buttond*1.3-0.05),0])
					cube([buttond*0.6-0.1,buttond,wall]);
				translate([-buttond*1.5+(buttond*0.6)/2,-(buttond*1.3)+0.05,0])
					cube([buttond*1.5-0.1,buttond*0.6-0.1,wall]);
			}
		}
		cylinder(r=0.5,h=wall);
	}
}



module frame_support(length, height)
{
	difference() {
		hull()
		{
			cube([length,0.1, 20]);
			translate([0,20,0])
				cube([length,0.1, 20]);
		}
		hull()
		{
			translate([0,0,5]) {
				cube([length+5,0.1, prusai3_frame_width]);
				translate([0,25,0])
					cube([length,0.1, prusai3_frame_width]);
			}
		}
	}
	
}
