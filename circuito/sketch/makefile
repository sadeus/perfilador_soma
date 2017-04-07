particle-cmd = ./node_modules/.bin/particle

install:
	@echo "Instalando particle-cli de forma local"
	@npm install particle-cli
	@$(particle-cmd) login

login:
	@$(particle-cmd) login

compile:
	@echo "Compilando archivo"
	@-rm *.bin
	$(particle-cmd) compile photon ./src --saveTo perfilador.bin --target 0.6.0

upload:
	@-read -p "Ingrese en modo DFU. Presione cualquier tecla para continuar"
	$(particle-cmd) flash --usb perfilador.bin

serial:
	$(particle-cmd) serial monitor

ip:
	@curl https://api.particle.io/v1/devices/240038001147343339383037/ip?access_token=cef0ec565f48c54fe8375d343a461087e274fa39
