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

### Software
- Python 3.x
- Numpy, Matplotlib, Scipy, Flask
- Web browser (Firefox, Chrome, Safari, _no funciona en IE_)


### Firmware
Para compilar, flashear y escuchar el puerto Serie del uC es necesario tener:
- NodeJS (Versión > v5.x)
- make

1. Ejecutar `make install`
2. Debe logearse con una cuenta de [particle.io](http://build.particle.io) para compilar
2. `make compile` `make upload` permiten compilar y actualizar por DFU respectivamente. Probablemente necesite permisos específicos para ejecutar DFU
2. Para ayuda del makefile, usar `make help`


