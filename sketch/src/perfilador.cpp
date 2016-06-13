#include "application.h"
#include "math.h"

//Modo semiautomático. No espera la conexión WiFi
SYSTEM_MODE(SEMI_AUTOMATIC);

//Server telnet
TCPServer server = TCPServer(23);
TCPClient client;

#define numMed 2000
unsigned int times[numMed];
unsigned int volts[numMed];


void setup() {
    // start listening for clients
    server.begin();

    Serial.begin(9600);

    RGB.control(true);
    RGB.color(255,0,0);

    //Rutina de conexión Wifi. Cambia de color a blanco el led
    if(!WiFi.ready()){
      WiFi.on();
      WiFi.setCredentials("chogar", "PEP0mkUP5F");
      WiFi.connect();
    }


    pinMode(D0,OUTPUT);
    digitalWrite(D0,HIGH);

    pinMode(D1, OUTPUT);
    int speed = 5000;
    for (int i = 0; i < speed; i += 10){
        analogWrite(D1, 128, i);
        delay(100);
    }

    //Pruebas
    pinMode(D3, OUTPUT);
    analogWrite(D3, 128, 10);
    RGB.color(0,255,0);

    setADCSampleTime(ADC_SampleTime_3Cycles);

}

void medirADC(){
  int i = 0;
  while (i < numMed){
    times[i] = micros();
    volts[i] = analogRead(A0);
    i++;
    delayMicroseconds(10);
  }
}



void loop() {
    Serial.println(WiFi.localIP());
    if (client.connected()) {
        medirADC();
        for (int j = 0; j < numMed; j++){
          server.print(times[j]);
          server.print(";");
          server.print(volts[j]);
          server.print("\n");
        }
        server.print("END");

    }
    else {
        client = server.available();
    }

}
