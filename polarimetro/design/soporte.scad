include <gears.scad>

distCage = 30;
dVarillaCage = 6;
dExt = 12;
dPol = 25.4/2;

m = 2;
zG = 40;
zC = 20;

rG = m * zG / ( 2* PI);
rC = m * zC / (2 * PI);

$fn = 100;


//Soporte
union() {
    difference(){
        union(){
            difference(){
                translate([10,0,0]){
                    cube([50, distCage-dVarillaCage*1.1, 10],center=true);
                }
                
                //Agujero del soporte
                cylinder(d=dPol+3.1,h=20,center=true);
                
                translate([rG+rC,0,0]){
                    cylinder(d=4.5,h=50,center=true);
                }
            }
            
            //Soporte del motor
            translate([rG+rC,0,-10]){
                difference(){
                    cube([22.5,distCage-dVarillaCage*1.1,20],center=true);
                }
            }
        }
        //Agujero del motor
        translate([rG+rC,0,-20]){
            cube([20.5,20.5,40],center=true);
        }
    }
    
    //Soporte del fotodiodo
    translate([0,0,-10]){
        difference(){
            cylinder(d=dPol+3.3,h=11,center=true);
            cylinder(d=8,h=12,center=true);
            translate([0,0,-5]){
                cylinder(d=10.2,h=12,center=true);
            }
        }
    }
    
    
    translate([50-10,0,-5]){
        difference(){
            cube([20,35,40],center=true);
            hRiel = 6;
            translate([5,0,0]){
                cube([10,20,40],center=true);
            }
        }
    }
}




