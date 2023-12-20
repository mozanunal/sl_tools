
PWD="$(shell pwd)"
USER="$(shell whoami)"
SEP="\e[1;32m-------------------------------------------\e[0m"

sync_sl_tools: \
	install_sl_tools \
	install_dwm \
	install_st \
	install_dmenu \
	install_slstatus \
	install_slock

##### Suckless Tools #################
install_sl_tools:
	@echo $(SEP) install_sl_tools
	sudo apt install -qq -y git patch diffutils \
		build-essential libglib2.0-dev \
		libxft-dev libimlib2-dev libxrandr-dev \
		libxinerama-dev

install_dwm:
	sudo rm -r build/dwm | true
	mkdir -p build
	cd build && git clone --depth=1 -b 6.3 git://git.suckless.org/dwm
	cp sl/dwm/* build/dwm/
	cd build/dwm \
		&& patch -i dwm-winicon-6.3-v2.1.diff \
		&& patch -i dwm-focusmaster-return-6.2.diff \
		&& patch -i dwm-cool-autostart-6.2.diff \
		&& patch -i dwm-scratchpad-6.2.diff \
		&& patch -i dwm-pertag-6.2.diff \
		&& patch -i dwm-r1615-selfrestart.diff \
		&& sudo make clean install

install_st:
	sudo rm -r build/st | true
	mkdir -p build
	cd build && git clone --depth=1 -b 0.9 git://git.suckless.org/st
	cp sl/st/* build/st/
	cd build/st \
		&& patch -i st-font2-0.8.5.diff \
		&& patch -i st-w3m-0.8.3.diff \
		&& patch -i st-scrollback-0.8.5.diff \
		&& patch -i st-desktopentry-0.8.5.diff \
		&& sudo make clean install

install_dmenu:
	sudo rm -r build/dmenu | true
	mkdir -p build
	cd build && git clone --depth=1 -b 5.2 git://git.suckless.org/dmenu
	cp sl/dmenu/* build/dmenu/
	cd build/dmenu \
		&& patch -i border-center-fuzzymatch.diff \
		&& sudo make clean install

install_slstatus:
	sudo rm -r build/slstatus | true
	mkdir -p build
	cd build && git clone --depth=1 -b master git://git.suckless.org/slstatus
	cp sl/slstatus/* build/slstatus/
	cd build/slstatus && sudo make clean install

install_slock:
	sudo rm -r build/slock | true
	mkdir -p build
	cd build && git clone --depth=1 -b 1.5 git://git.suckless.org/slock
	cp sl/slock/* build/slock/
	cd build/slock \
		&& patch -i slock-blur_pixelated_screen-1.4.diff \
		&& sudo make clean install

default: sync_sl_tools
