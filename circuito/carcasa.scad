sizeHueco = [50+25,52,30];

sizeTapa = sizeHueco - [0, 0, sizeHueco[2]] + [5,3,2];

$fn=50;

translate([0,0,sizeHueco[2]/2])
difference(){
    cube(sizeHueco + 5 * [1, 1, 0], center=true);

    translate([0,0,5]){
        cube(sizeHueco, center=true);
    }
    
     /*for (i = [-45, 45, 90+45,180 + 45]){
        pos = [(sizeHueco[0] + 10)/sqrt(2) * cos(i), (sizeHueco[1] + 10)/sqrt(2) * sin(i), 10];
        
        translate(pos){
            cylinder(d=5, h=20, center = true, $fn = 50);
        }
    }*/
    
    //BNC fotodiodo
    translate([0,-sizeHueco[1]/2,5]){
        rotate([90,0,0]){
            cylinder(d=8,h=20,center=true);
        }
    }
    
    //Jack tensión
    translate([20,-sizeHueco[1]/2,5]){
        rotate([90,0,0]){
            cylinder(d=11,h=20,center=true);
        }
    }
    
    //Cable plano de motor
    translate([-20,-sizeHueco[1]/2,5]){
        cube([20,20,10], center=true);
    }
    
    
    translate([2.5,0,sizeHueco[2]/2 - 1]){
        cube(sizeTapa + [0.1,0.1,0.1], center = true);
    }
}

translate([100,0,0]){
    cube(sizeTapa, center = true);
   
}