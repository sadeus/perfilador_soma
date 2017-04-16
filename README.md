# labo6_7
Material creado durante el laboratorio 6 y 7 de la carrera de Ciencias Físicas de FCEyN, UBA

## Contenido
Se crearon sensores optomecánicos portátiles, para poder medir cambios de los haces de los setups del laboratorio. Todo el marco del proyecto SOMA

### Indice de carpetas
- software: Software para la adquisición y visualización de las mediciones. Acá se efectúa el análisis de los datos obtenidos
- firmware: Código para el uC para el polarimetro/perfilador. Tiene un makefila con los métodos usuales
- circuito: Diseño del circuito impreso
- perfilador: Diseño mecánico del perfilador
- polarimetro: Diseño mecánico del polarimetro
- espectrometro: Diseño del circuito para el espectrómetro (EN PROGRESO)

## Instalación

Para poder instalar y usar el software/firmware de este proyecto es necesario tener [NodeJS](https://nodejs.org/es/):

- Linux, macOS: Instalación por manejador de paquetes, [aquí](https://nodejs.org/es/download/package-manager/)
- Windows: Descargar binario de la página oficial

En una command prompt o terminal escribir lo siguiente para instalar dependencias

```npm install```

Esto instala las dependencias de firmware y software. Para obtener ayuda de los comandos disponibles ejecutar

```npm run```

### Lista de comandos
- `npm run ip`: abre el puerto serie creado al conectar el uC y obtiene la ip del dispositivo
- `npm run start`: inicia el servidor web del software de adquisición. Por defecto se entra en un browser en http://localhost:9000
- `npm run compile`: compila el firmware. Para compilar el firmware, por ahora, es necesario logearse con `npm run login` y una cuenta de [particle.io](http://build.particle.io)
- `npm run upload`: Actualiza el firmware del uC por USB. Es necesario tener el uC en modo DFU (ver [acá](https://docs.particle.io/guide/getting-started/modes/photon/#dfu-mode-device-firmware-upgrade-))

## Dependencias

### Software
- Python ^v3.5.0
- Numpy >v1.11.3
- Pandas >v0.19.2
- Matplotlib >v1.9.0
- Scipy >v0.18.1
- Flask >v0.12
- Web browser (Firefox, Chrome, Safari, _no funciona en IE_)

### Firmware
Para compilar, flashear y escuchar el puerto Serie del uC es necesario tener:
- NodeJS >v6.0
- Particle-cli ^v1.21.0
- readline-sync (para interfaz interactiva)
