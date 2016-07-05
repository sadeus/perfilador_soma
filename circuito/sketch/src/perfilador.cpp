#include "application.h"

//#define DEBUG //Modo debug
#define SENSOR 1 //0 => Perfilador, 1 => Polarizador
#if SENSOR == 0
#define SPEED 6000
#else
#define SPEED 2000
#endif

//Modo semiautomático. No espera la conexión WiFi
SYSTEM_MODE(MANUAL);

//Server telnet
TCPServer server = TCPServer(23);
TCPClient client;

//Variables para mediciones
#define N_MED 4000

//Pines del motor paso a paso
#define STEPPER_DIR_PIN D0
#define STEPPER_STEP_PIN D1


    

class Sensor {
	public:
		unsigned int x[N_MED];
		unsigned int y[N_MED];
		
		Sensor() {
		    pinMode(STEPPER_DIR_PIN, OUTPUT);
		    pinMode(STEPPER_STEP_PIN, OUTPUT);
		    
		    digitalWrite(STEPPER_DIR_PIN, HIGH);
		    for (int i = 0; i < SPEED; i+=10){
			    analogWrite(STEPPER_STEP_PIN, 128, i);
			    delay(5);
		    }
		   
		}
        
        void measure() {
		    attachInterrupt(STEPPER_STEP_PIN, &Sensor::countStep, this, RISING);
            delay(N_MED/SPEED);
        }

	private:
		volatile int step = 0;
		void countStep(){
			if (step == N_MED) {
                    pinResetFast(D7);
        			step = 0;
                    detachInterrupt(STEPPER_STEP_PIN);
    			}
    			else {
                    pinSetFast(D7);
                    x[step] = step;
                    y[step] = analogRead(A0);
        			step++;
    			}
		}

};

Sensor sens;  //Construyo el sensor, inicializa el motor


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
        IPAddress addr(192,168,0,100);
        IPAddress netmask(255,255,255,0);
        IPAddress gateway(192,168,0,1);
        IPAddress dns(192,168,0,1);
        WiFi.setStaticIP(addr, netmask, gateway, dns);
        WiFi.useStaticIP();
        WiFi.connect();
    }
}

void loop() {
    if (client.connected()) {
        sens.measure();
             
        for (int i = 0; i < N_MED; i++){
            client.print(sens.x[i]);
            client.print(";");
            client.println(sens.y[i]);
        }
        client.print("END");
        
        client.stop();
    }
    else {
        client = server.available();
    }

}

