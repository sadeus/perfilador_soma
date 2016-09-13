# Perfilador de haz
## Proyecto SOMA

### Especificaciones
#### Mecánicas
* Dimensiones sin prolongación: 40x40x60 mm
* Dimensiones de prolongación: 50 mm desde centro del soporte, 8x20 mm 
* Diametro máximo de haz perfilable: 10 mm 
* Velocidad de adquisición: 40 perfiles/s
* Forma de fotodiodo: TO-5

#### Software embebido
* Microcontrolador: Particle Photon
    - STM32F205 120Mhz ARM Cortex M3
    - 1MB Flash
    - 128KB RAM
    - Broadcom BCM43362 Wi-Fi chip. 802.11b/g/n 2,4GHz
* Implementación en C++

#### Software PC
* Adquisición cada 1s de 40 perfiles
* Python v3.x
    - Numpy
    - Scipy
    - Matplotlib
    - PyQT
