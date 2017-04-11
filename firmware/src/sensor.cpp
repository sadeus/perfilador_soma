#include "application.h"

#define PORT 7662
#define OLED 0 //Uso del OLED

//Modo manual

//System.disable(SYSTEM_FLAG_RESET_NETWORK_ON_CLOUD_ERRORS);


#define WIFI 1  //Uso del WiFi
#define CLOUD 0 //Uso de Cloud
#define SSID "WiFi-LEC"
#define PASS "coefilec"
String ip;

#if CLOUD == 0
	SYSTEM_MODE(MANUAL);
#endif

#define SENSOR 0 //0 => Perfilador, 1 => Polarizador
#if SENSOR == 0
#define SPEED 6000
#else
#define SPEED 2000
#endif


//Server telnet
TCPServer server = TCPServer(PORT);
TCPClient client;

//Variables para mediciones
#define N_MED 4000

//Pines para el motor y el ADC
#define STEPPER_DIR_PIN D0
#define STEPPER_STEP_PIN D1
#define SENSOR_PIN A0

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
        			step = 0;
              detachInterrupt(STEPPER_STEP_PIN);
    			}
    			else {
              x[step] = step;
              y[step] = analogRead(SENSOR_PIN);
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
	#if WIFI == 1
		if (WiFi.clearCredentials()){
			RGB.control(true);
		  RGB.color(255,0,0);
			WiFi.on();
			WiFi.setCredentials(SSID, PASS);
			WiFi.useDynamicIP();
	    WiFi.connect();
			while (!WiFi.ready()){ }

			ip = String(WiFi.localIP());

			#if CLOUD == 1
				Particle.variable("ip", ip);
			#endif

			RGB.color(0,255,0);
		}
	#endif
}

//Variables para imprimir IP por puerto serie
int prevT = 0;
int deltaT = 1000;


void loop() {

    //Devuelvo la IP
    int currT = millis();
  	if (currT - prevT > deltaT) {
    	Serial.print("Ip: ");
    	Serial.println(WiFi.localIP());
			prevT = currT;
		}

    if (client.connected()) {

      //Recién ahora que me piden, mido
      sens.measure();

      //Mando al cliente que escucha en el servidor
      for (int i = 0; i < N_MED; i++){
        client.print(sens.x[i]);
        client.print(";");
        client.println(sens.y[i]);
      }
      //Fin de transmisión
      client.print("END");
      client.stop();

    }
    else {
      client = server.available();
    }
}
