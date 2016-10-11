compile: 
	-rm *.bin 
	particle compile photon ./src --saveTo perfilador.bin
	
upload: 
	-read -p "Ingrese en modo DFU. Presione cualquier tecla para continuar"
	sudo particle flash --usb perfilador.bin

serial:
	particle serial monitor
