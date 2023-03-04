/** TODO
 * 
 * [x] bottom cutout
 * [x] place clip hole higher
 * [x] lessen sideways play makita slide
 * [x] place conn higher
 * [x] lower conn
 * [x] enlarge conn holder lips
 * [x] slim down outer size
 *
 */


WIDTH = 72; // [70:1:100]

$fn = 32;

union()
difference(){
	makitaSlide();
	// conn holder hole
	translate([0, 0, 66]){
		// through hole
		rotate([-90, 0, 0])
		linear_extrude(100)
			makitaConnProfile("in");
		// space for lips
		translate([0, 17, 0])
		rotate([-90, 0, 0])
		linear_extrude(100)
			makitaConnProfile("out");
	}
	// retention clib hole
	intersection(){
		// angeled block
		translate([-20, 15, 70])
		rotate([60, 0, 0])
			cube([40, 30, 30]);
		// flat piece
		translate([-25, 0, 65])
			cube([50, 100, 17]);
	}
	
	translate([-0.5*WIDTH, 19, 30])
		pdBoard();
}

module pdBoard(){
	translate([0, 8, 0])
		cube([48, 5, 34]);
	translate([12, 4.5, 7]){
		cylinder(d=9, h=20);
		translate([-4.5, 0, 0])
			cube([9, 4.5, 20]);
	}
	//%cube([48, 13, 34]);
}

module makitaSlide(){
	difference(){
		union(){
			// bottom block
			translate([-0.5*WIDTH, 0])
				cube([WIDTH, 25, 13]);
			// makita slide big stage
			linear_extrude(37)
				makitaSlideProfile("b");
			// makita slide small stage
			linear_extrude(65)
				makitaSlideProfile("a");
			// main body
			translate([-0.5*WIDTH, 14.75, 0])
				cube([WIDTH, 12.25, 85]);
		}
		// bottom cutout
		translate([0, 0, 13])
		rotate([-90, 0, 0])
		hull() {
			translate([13, 0, 0])
				cylinder(r=14, h=7, center=true);
			translate([-13, 0, 0])
				cylinder(r=14, h=7, center=true);
		}
		// top cutout
		translate([0, 14.75-3.5, 77.5]){
			rotate([0, 90, 0])
				cylinder(r=5, h=WIDTH*2, center=true);
			translate([0, 0, 50])
				cube([WIDTH*2, 10, 100], center=true);
		}
	}
}


module makitaSlideProfile(part){
	module half()
		union(){
			// hook point
			translate([27, 0])
				square([6, (part=="a")?6:7]);
			// hook lag
			translate([31, 0])
				square([0.5*WIDTH-31, 16]);
			// hook body
			translate([-1, 14.75])
				square([0.5*WIDTH+1, 10]);
		}
	union(){
		half();
		mirror([1, 0, 0])
			half();
	}
}

module makitaConnProfile(part){
	lip = (part == "in") ? 0 : 2.2;
	union(){
		// big piece
		translate([0, 18.5])
			square([44.5 + 2*lip, 37 + 2*lip], center=true);
		// small protudeing piece
		translate([0, 37 + 6.25])
			square([20.5 + 2*lip, 12.5 + 2*lip], center=true);
	}
}


