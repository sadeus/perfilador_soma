particle-cmd = ./node_modules/.bin/particle

clean_node:
	@echo "Borrando node_modules"
	@rm -rf ./node_modules

install:
	@echo "Instalando particle-cli de forma local"
	@npm install particle-cli
	@$(particle-cmd) login

login:
	@$(particle-cmd) login

clean:
	@echo "Eliminado compilado"
	@-rm *.bin

compile:
	@echo "Compilando archivo"
	@-rm *.bin
	@$(particle-cmd) compile photon ./src --saveTo perfilador.bin --target 0.6.0

upload:
	@-read -p "Ingrese en modo DFU. Presione cualquier tecla para continuar"
	@$(particle-cmd) flash --usb perfilador.bin

ip serial:
	@echo "Escuchando puerto serie"
	@$(particle-cmd) serial monitor


cloud_ip:
	@curl https://api.particle.io/v1/devices/240038001147343339383037/ip?access_token=cef0ec565f48c54fe8375d343a461087e274fa39
