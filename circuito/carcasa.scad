sizeHueco = [50+23,52,20];

difference(){
    cube(sizeHueco + 20 * [1, 1, 1], center=true);

    translate([0,0,10]){
        cube(sizeHueco, center=true);
    }
    
     /*for (i = [-45, 45, 90+45,180 + 45]){
        pos = [(sizeHueco[0] + 10)/sqrt(2) * cos(i), (sizeHueco[1] + 10)/sqrt(2) * sin(i), 10];
        
        translate(pos){
            cylinder(d=5, h=20, center = true, $fn = 50);
        }
    }*/
    
    //BNC fotodiodo
    translate([0,-sizeHueco[1]/2,10]){
        rotate([90,0,0]){
            cylinder(d=11,h=20,center=true);
        }
    }
    
    //Jack tensión
    translate([20,-sizeHueco[1]/2,10]){
        rotate([90,0,0]){
            cylinder(d=11,h=20,center=true);
        }
    }
    
    //Cable plano de motor
    translate([-20,-sizeHueco[1]/2,10]){
        cube([20,20,10], center=true);
    }
    
}
