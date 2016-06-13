alturaEje = 50;
motorSize = [20,20,48]; //Tamaño del motor
clearing = 20;
alturaPerros = 10;
anchoPerros = 15;

distFotodiodo = 50;

diametroPhExt = 16;
diametroPhInt = 8;



sizeSoporte = [motorSize[2], motorSize[1], alturaEje + motorSize[0]/2] + [0.5,1,0] * clearing;
difference(){
    translate([0,0,sizeSoporte[2] / 2]){
        
        difference(){

            cube(sizeSoporte, center=true);
          
            
            cylinder(h= alturaEje + motorSize[0], r=3.5, center=true, $fn=50);
            
            translate([0,0,5]){
                cylinder(h= alturaEje + motorSize[0] - 15, r=6 , center=true, $fn = 50);
            }
            
            
            

            //Perros
            translate([0,0,-5]){
                difference(){
                    cube(sizeSoporte - [0,0,1] * (sizeSoporte[2] - alturaPerros), center=true);
                    cube(sizeSoporte - anchoPerros * [1,1,0] - (sizeSoporte[2] - alturaPerros) * [0,0,1], center=true);
                }
            }
        }
    }

    //Encastre del motor
    translate([-10, 0, alturaEje + 10]){
        cube([motorSize[2] + 20,motorSize[0],motorSize[1] + 20],center=true);   
        
}
    
    translate([0,0,alturaEje]){
        rotate([0, 90, 0]){
                    cylinder(d=6, h=motorSize[2], $fn=50);
        }
    }
    
    
}




//Soporte fotodiodo

    
 translate([distFotodiodo, (7/2 - sizeSoporte[1]/2), alturaEje]){
    difference(){
        translate([-distFotodiodo/4 , 0, 0]){
            cube([distFotodiodo/2 + 20, 7, 20], center = true);
        }


        
        rotate([90,0,0]){
            cylinder(d = diametroPhInt, h = 30, center = true);
            translate([0,0,6]){
                cylinder(d = diametroPhExt, h=10, center = true);
            }
        }

        
    }
}

      





