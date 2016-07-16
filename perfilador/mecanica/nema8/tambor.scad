rHaz = 4;
hTotal = 30;
alturaBase = 12;
dTambor = 15;
dEje = 4;

$fn = 100;


module tambor(){
    difference(){
        cylinder(d=dTambor,h=hTotal);

        translate([-rHaz,-10,alturaBase]){
            cube([20,20,30]);
        }
        
        cylinder(d=dEje,h=hTotal);
    }
}