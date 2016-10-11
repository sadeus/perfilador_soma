include <gears.scad>


dPol = 25.4/2;  //Media pulgada de polarizador
dEje = 16;
m = 2;
zG = 35;
zC = 20;

rG = m * zG / ( 2* PI);
rC = m * zC / (2 * PI);


$fn = 500;
module engranajes(){
//Eje


    translate([0,0,-15]){
    union(){
         difference(){
            union(){
                
                //Engranaje
                translate([0,0,10]){
                    gear(mm_per_tooth = m, number_of_teeth = zG, thickness = 10);
                }
                //Eje adosado al engranaje
                cylinder(d = dEje , h = 10, center = true);
                
                
            }
            //Agujero del eje
            cylinder(d = dPol + 0.5 , h = 50, center = true);
                 
        }
        
        
        //Stop de engranaje. Impide que se salga de lugar hacía adelante
        translate([0,0,4.5]){
            difference(){
                cylinder(r=rG+2, h = 1.5, center=true);
                cylinder(d = dEje , h = 1.5, center = true);
            }
        }
        
        //Apoyo de la lámina
        difference(){
                cylinder(d = dPol + 0.5 , h = 2, center = true);
                cylinder(d = dPol - 1 , h = 2, center = true);
        }
    }
}



    //Engranaje motor
    
        translate([rC+rG ,0,-5]){
            rotate([0,0, m * zG*180/PI]){
                difference(){
                    gear(mm_per_tooth = m, number_of_teeth = zC, thickness = 10);
                    cylinder(d=4,h=20,$fn=50,center=true);
                }
            
            }
        }
}




