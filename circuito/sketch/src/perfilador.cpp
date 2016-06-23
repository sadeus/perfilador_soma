// This #include statement was automatically added by the Particle IDE.
#include "application.h"

//Modo semiautomático. No espera la conexión WiFi
SYSTEM_MODE(MANUAL);

//Server telnet
TCPServer server = TCPServer(23);
TCPClient client;

#define numMed 4000
unsigned int times[numMed];
unsigned int volts[numMed];


// Define some steppers and the pins the will use
#define STEPPER_DIR_PIN D0
#define STEPPER_STEP_PIN D1


class Perfilador {
    public:
        Perfilador() {
            pinMode(STEPPER_DIR_PIN, OUTPUT);
            pinMode(STEPPER_STEP_PIN, OUTPUT);

        }


        void start(){
            digitalWrite(STEPPER_DIR_PIN, HIGH);
            for (int i = 0; i < speed; i+=10){
                analogWrite(STEPPER_STEP_PIN, 128, i);
                delay(5);
            }
        }

        void measure(){

            for (int i = 0; i < numMed; i++){
                times[i] = micros();
                volts[i] = analogRead(A0);
                //delayMicroseconds(10);
            }

            for (int i = 0; i < numMed; i++){
                server.print(times[i]);
                server.print(";");
                server.println(volts[i]);
            }

            server.print("END");

        }

    private:
        int speed = 1000;
};


class Polarimetro {
    public:
        Polarimetro() {
            pinMode(STEPPER_DIR_PIN, OUTPUT);
            pinMode(STEPPER_STEP_PIN, OUTPUT);

            digitalWrite(STEPPER_DIR_PIN, HIGH);
            for (int i = 0; i < speed; i+=10){
                analogWrite(STEPPER_STEP_PIN, 128, i);
                delay(5);
            }



        }

        void measure(){
            analogRead(A0);
            delayMicroseconds(20);

        }

    private:
        int speed = 2000;


};

Perfilador perf;

//Polarimetro pol;

void setup() {
    //Clientes
    server.begin();
    Serial.begin(9600);

    //ADC speed
    setADCSampleTime(ADC_SampleTime_3Cycles);

    //Configuro WiFi
    WiFi.on();
    if (!WiFi.ready()){
        WiFi.setCredentials("LECfi", "coefilec");
        IPAddress addr(192,168,0,200);
        IPAddress netmask(255,255,255,0);
        IPAddress gateway(192,168,0,1);
        IPAddress dns(192,168,0,1);
        WiFi.setStaticIP(addr, netmask, gateway, dns);
        WiFi.useStaticIP();
        WiFi.connect();
    }
    //Perfilador
    perf.start();



}

void loop() {
    //pol.measure();
    Serial.println(WiFi.localIP());
    if (client.connected()) {
        perf.measure();
        client.stop();
    }
    else {
        client = server.available();
    }

}
