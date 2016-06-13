rHaz = 3;
hTotal = 30;
alturaBase = 10;
dTambor = 15;
dEje = 5;


difference(){
    cylinder(d=dTambor,h=hTotal);

    translate([-rHaz,-10,alturaBase]){
        cube([20,20,30]);
    }
    
    cylinder(d=dEje,h=hTotal, $fn=40);
}