include <soporte.scad>
include <engranajes.scad>

rotate([0,90,-90]){
    soporte();
    translate([0,0,20]){
    engranajes();
    }
}