function radius_to_balls(r_ball, r) = 180 / asin(r_ball / r);
function ball_to_radius(n, r) = r * sin(180 / n);

module Bearing(outer, inner, attempt, gap, hole, height) {
	n = round(radius_to_balls(attempt, inner));
	r = ball_to_radius(n, inner);
	theta = 360 / n;
	pinRadius = 0.5 * r;
    
    // The pins:
	for(i = [0 : n]){
		rotate(a = [0, 0, theta * i]){
			translate([inner, 0, 0]){
                sphere(r = r - 0.5*gap, center = true, $fn = 45);
                
            }
        }
    }
				
// The inner race:
	difference() {
		rad = inner - pinRadius - gap;
		cylinder(r1 = rad, r2 = rad, h = height, center = true, $fn = 45);
		rotate_extrude(convexity = 10){
			translate([inner, 0, 0]){
				circle(r = r + gap, $fn = 30);
            }
        }
        cylinder(d = hole, h = height + 5, center = true, $fn = 45);
	}
// The outer race:
	difference() {
		cylinder(r = outer, h = height, center = true, $fn = 45);
		rad = inner + pinRadius + gap;
			cylinder(r1 = rad, r2 = rad, h = height + 5, center = true, $fn = 45);
		rotate_extrude(convexity = 10)
			translate([inner, 0, 0])
				circle(r = r + gap, $fn = 45);
	}
}
