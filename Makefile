build:
	git submodule update --init
	cd docker; podman build -t infinitime-build .; cd ..
	podman run --rm -it -v ${PWD}:/sources --user $(id -u):$(id -g) infinitime-build

flash:
	systemctl --user start itd
	../itd/itctl fw upg -a build/output/pinetime-mcuboot-app-dfu-1.15.0.zip
	../itd/itctl res load build/output/pinetime-resources-1.15.0.zip
	systemctl --user stop itd
