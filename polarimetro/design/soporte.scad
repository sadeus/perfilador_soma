include <gears.scad>

distCage = 30;
dVarillaCage = 6;
dExt = 12;
dPol = 25.4/2;

m = 2;
zG = 35;
zC = 20;

rG = m * zG / ( 2* PI);
rC = m * zC / (2 * PI);

echo(rG);
echo(rC);
$fn = 100;


//Soporte
module soporte(){
    difference() {
        union() {
            difference(){
                union(){
                    difference(){
                        translate([10,0,0]){
                            cube([50, 22, 10],center=true);
                        }
                       
                        //Agujero del soporte
                        translate([0,0,1]){ 
                            cylinder(d=16,h=10,center=true);
                        }
                        
                    }
                    
                    //Soporte del motor
                    translate([19,0,-10]){
                        difference(){
                            cube([22,22,20],center=true);
                        }
                    }
                }
                
                translate([rG+rC,0,-15]){
                    cube([20.1,20.1, 20],center=true);
                }
                
                //Agujero del motor
                        translate([rG+rC,0,0]){
                            cylinder(d=4,h=50,center=true);
                    }
            }
            
            
            //Soporte del fotodiodo
            translate([0,0,-9]){
                    cylinder(d=14,h=10,center=true);
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
        
        translate([0,0,-12]){
                cylinder(d=12,h=5,center=true);
            }
        
        cylinder(d=8,h=50,center=true);

    }
}


