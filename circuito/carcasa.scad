sizeHueco = [90, 90 , 35];

sizeTapa = sizeHueco - [0, 0, sizeHueco[2]] + [5,2,2];

$fn=50;

translate([0,0,sizeHueco[2]/2]){
    difference(){
        
        //Carcasa exterior
        cube(sizeHueco + 4 * [1, 1, 0], center=true);
        
        //Hueco
        translate([0,0,6]){
            cube(sizeHueco, center=true);
        }
        
        //Circuito
        translate([15,10,-10]){
            cube([50,50,10], center = true);
        }

        //Regulador
        translate([-25,10,-10]){
            cube([25,40,10], center = true);
        }

        
        //BNC fotodiodo
        translate([10,-sizeHueco[1]/2,5]){
            rotate([90,0,0]){
                cylinder(d=10,h=20,center=true);
            }
        }
        
        //Jack tensión
        translate([-30,-sizeHueco[1]/2,5]){
            rotate([90,0,0]){
                cylinder(d=8,h=20,center=true);
            }
        }
        
        //Cable plano de motor
         translate([-10,-sizeHueco[1]/2,5]){
            cube([15,8,5], center=true);
        }
        
        //USB
         translate([30,-sizeHueco[1]/2,5]){
            cube([10,10,5], center=true);
        }
        
        //Agujero de tapa
        translate([2.5,0,sizeHueco[2]/2 - 1]){
            cube(sizeTapa + [0.1,0.1,0.1], center = true);
        }
        
        
    }

}


//Tapa
translate([100,0,0]){
    cube(sizeTapa, center = true);
   
}



