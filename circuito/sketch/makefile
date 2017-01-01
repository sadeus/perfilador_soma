compile:
	-rm *.bin
	particle compile photon ./src --saveTo perfilador.bin --target 0.6.0

upload:
	-read -p "Ingrese en modo DFU. Presione cualquier tecla para continuar"
	particle flash --usb perfilador.bin

serial:
	particle serial monitor

ip:
	curl https://api.particle.io/v1/devices/240038001147343339383037/ip?access_token=cef0ec565f48c54fe8375d343a461087e274fa39
