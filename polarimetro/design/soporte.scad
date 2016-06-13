include <bearing.scad>
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


//Soporte
union() {
    difference(){
        translate([10,0,0]){
            cube([50, distCage-dVarillaCage*1.1, 20],center=true);
        }
        cylinder(d=dExt*1.1,h=20,center=true);
        
        translate([rG+rC,0,0]){
            cylinder(d=5,h=50,$fn=50,center=true);
        }
        
        //Agujero pasante para roscado a mesa
        rotate([0,90,0]){
            union(){
                cylinder(d=10,h=60,center=true, $fn=20);
                
                 translate([0,0,10]){
                    
                    cylinder(d=6,h=60,center = true,$fn=20);
                 }
        
            }
        }

    }
    
    //Soporte del motor
    translate([rG+rC,0,-20]){
        difference(){
            cube([25,distCage-dVarillaCage*1.1,20],center=true);
            cube([20,20,40],center=true);
            
        }
    }
    
    translate([0,0,-20]){
        difference(){
            cylinder(d=dPol*1.2,h=20,center=true,$fn=20);
            cylinder(d=10,h=20,center=true,$fn=20);
        }
    }
}

//Eje
union(){
     difference(){
        union(){
            
            //Engranaje
            translate([0,0,15]){
                gear(mm_per_tooth = m, number_of_teeth = zG, thickness = 10);
            }
            //Eje adosado al engranaje
            cylinder(d = dPol + 3 , h = 20, center = true, $fn=50);
            
            
        }
        //Agujero del eje
        cylinder(d = dPol + 0.5 , h = 50, center = true, $fn=50);
             
    }
    
    //Apoyo de la lámina
    difference(){
            cylinder(d = dPol + 0.5 , h = 2.5, center = true, $fn=50);
            cylinder(d = dPol - 1 , h = 2.5, center = true, $fn=50);
    }
}


//Engranaje motor
translate([rG+rC,0,15]){
        difference(){
                    gear(mm_per_tooth = m, number_of_teeth = zC, thickness = 10);
        cylinder(d=5,h=20,$fn=50,center=true);
    }
    
}

//Bearing(outer = dExt, inner = dExt - 4, attempt = 3, gap = 0.2, height = 10, hole = dPol);



//Cage para referencia
for (i = [-45,45,90+45,180+45]){
    translate(distCage/sqrt(2) * [cos(i),sin(i),0]){
        cylinder(d = dVarillaCage, h = 50, center = true);
    }
        
}


