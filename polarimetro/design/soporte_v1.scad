include <publicDomainGearV1.1.scad>

ejeSize = 25.4/2;

m = 1; //Modulo de engranajes

//Pasos del engranaje.
zG = 18;
zM = 18;
zC = 9; 

//Radios de engranajes
rG = (m * zG)/2;  
rM = (m * zM)/2;
rC = (m * zC)/2;

motorSize = [20,20,48]; //Tamaño del motor


//Cálculo del hueco para los engranajes
anchoHueco = 2 * (rC  + rC + rG);
altoHueco = 2 * (rM  + rM + rG) + 3;
deltaHx = 0; //((2 * rC + rG) - (rC / sqrt(2) + rC + rG)); //Delta del hueco para ubicar los engranajes de forma centrada
screwSize = 4.1;


angles = [30,330]; //Angulos de los engranajes "planetarios"

deltaZGear = [0,0,10]; //Posición en Z de los engranajes. Estético
altGear = 10;   //Altura de los engranajes



//Verificaciones y medidas máximas
if ((altoHueco - 50) > (altoHueco / 2)){
    echo("Error. Eje óptico a más de 50mm del vertice inferior");
}

if ((2 * rC + rG) > (30 * sqrt(2) / 2)) {
    echo("No entra en el Cage 30mm");
}

echo(str("Altura: ", altoHueco + 15));
echo(str("Anchura: ", anchoHueco + 15));

union(){
    
    //Caja con hueco para engranajes. Agujeros M3 para ajustar
    difference() {
        
        cube([altoHueco + 15, anchoHueco + 15, 20], center=true);
        translate([deltaHx,0,10]){
            cube([altoHueco, anchoHueco, 15], center=true);
        }
        
        //Agujero del lente
        union(){
            translate([0,0,-5]){
                cylinder(h=10, d=ejeSize,center=true, $fn=50);
            }
            cylinder(h=10, d=10,center=true, $fn=50);
            
        }
        

        //Agujeros pasantes para adosar tapa
        for(i = [45:90:360-45]){
            pos = sqrt(2)/2 * [(anchoHueco + 6) * cos(i),  (altoHueco + 6) * sin(i), 0] + [deltaHx, 0, 0];
            translate(pos){
                cylinder(h=60, r = screwSize/2, center=true, $fn = 50);
            }
        }
        
        //Eje del motor
        translate([-(rG + rM),0,20]){
            cylinder(d=5,h=motorSize[2] + 30,center=true,$fn=50);
        }
        
        //Entradas para el Cage
        rotate([0,0,-90]){
            translate([15,15,0]){
                cube([6,60,20],center=true);
            }
        }
        
        rotate([0,0,-90]){
            translate([-15,15,0]){
                cube([6,60,20],center=true);
            }
        }
        
        
    }
    
    
    //Soporte del motor
    translate([-(rG + rM), 0, -motorSize[2]/2 - 10]){
        difference(){
  
            
            cube(motorSize + 4 * [1,1,0] ,center=true);
            
            cube(motorSize, center=true);
            
            cylinder(d=5,h=50, center = true);
            
            
            
        }
        
        
        
    }
    
    /*translate([0,0,-10]){
        difference(){
            cylinder(h=15,r=25.4/2, center=true);
            translate([0,0,5]){
                cylinder(h=10,r=5, center=true);
            }
            translate([0,0,-5]){
                cylinder(h=10,r=8, center=true);
            }
        }
    }*/

    //Soporte de los engranajes
    for (i = angles){
        if (i != 0){
            pos = (rG + rC) * [cos(i), sin(i), 0];
            translate(pos + deltaZGear){
                cylinder(h=20, r=2.5,center=true, $fn=50);
            }
        } 
    }
    
    
}



//*****************Engranajes************************//

//Grande
translate(deltaZGear){
    difference(){
        gear(mm_per_tooth = m * PI, number_of_teeth = zG, hole_diameter = 5, thickness = altGear);
        //Agrego agujero para lámina de 1''
        cylinder(h=20,d=ejeSize,center = true);
    }
    
}

//Mediano
translate([-(rG + rM),0,0] + deltaZGear){
    ang = rM/zM * 180;
    difference(){
        rotate([0,0,ang]){
            gear(mm_per_tooth = m * PI, number_of_teeth = zM, thickness = altGear);
        }
        //Agrego agujero para lámina de 1''
        cylinder(h=20,d=5,center = true, $fn=20);
    }
    
}


//Chico
for (i = angles){
    ang = i != 30 ? 0  : (i * 180 * rC/zC);
    
    pos = (rG + rC) * [cos(i), sin(i), 0];
    translate(pos + deltaZGear){
        difference(){
           rotate([0, 0,  ang]){
                gear(mm_per_tooth = m * PI, number_of_teeth = zC, thickness = altGear);
            }
            if (i != 0) {
                % cylinder(h=20,r=2.5,center = true, $fn=20);
            }
        }
    }

}

//***********************Cage**************************//

sizeCage = 30;
for (i = [45:90:360-45]){
    pos = sizeCage * sqrt(2) / 2 * [cos(i),sin(i),0];
    translate(pos){
        cylinder(d=6,h=100,center=true);
    }
}



