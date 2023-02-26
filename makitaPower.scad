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

difference(){
	makitaSlide();
	// conn holder hole
	translate([0, 0, 65-2]){
		// through hole
		rotate([-90, 0, 0])
		linear_extrude(100)
			makitaConnProfile("in");
		// space for lips
		translate([0, 19, 0])
		rotate([-90, 0, 0])
		linear_extrude(100)
			makitaConnProfile("out");
	}
	// retention clib hole
	intersection(){
		// angeled block
		translate([-20, 15, 65])
		rotate([60, 0, 0])
			cube([40, 30, 30]);
		// flat piece
		translate([-25, 0, 65])
			cube([50, 100, 17]);
	}
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
				cube([WIDTH, 10, 85]);
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
	}
}


module makitaSlideProfile(part){
	module half()
		union(){
			// hook point
			translate([27, 0])
				square([6, (part=="a")?5.5:6.5]);
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
	lip = (part == "in") ? 0 : 3;
	union(){
		// big piece
		translate([0, 17])
			square([44.5 + 2*lip, 37 + 2*lip], center=true);
		// small protudeing piece
		translate([0, 37 + 6.25])
			square([20.5 + 2*lip, 12.5 + 2*lip], center=true);
	}
}


