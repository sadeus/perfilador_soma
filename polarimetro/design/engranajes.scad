include <gears.scad>


dPol = 25.4/2;  //Media pulgada de polarizador
dEje = dPol + 3;
m = 2;
zG = 40;
zC = 20;

rG = m * zG / ( 2* PI);
rC = m * zC / (2 * PI);

$fn = 100;

//Eje
    rotate([0,180,0]){

    translate([0,0,-15])
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
        
        //Apoyo de la lámina
        difference(){
                cylinder(d = dPol + 0.5 , h = 2.5, center = true);
                cylinder(d = dPol - 1 , h = 2.5, center = true);
        }
    }



    //Engranaje motor
    translate([25,0,-5]){
            
        difference(){
            gear(mm_per_tooth = m, number_of_teeth = zC, thickness = 10);
            cylinder(d=4,h=20,$fn=50,center=true);
        }
        
    }
}





