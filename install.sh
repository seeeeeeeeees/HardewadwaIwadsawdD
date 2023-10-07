#!/bin/bash
Infon()
{
 printf "\033[1;32m$@\033[0m"
}
Info()
{
 Infon "$@\n"
}
Error()
{
 printf "\033[1;31m$@\033[0m\n"
}
Error_n()
{
 Error "$@"
}
Error_s()
{
 Error "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "
}
log_s()
{
 Info "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "
}
log_n()
{
 Info "$@"
}
log_t()
{
 log_s
 Info "- - - $@"
 log_s
}
log_tt()
{
 Info "- - - $@"
 log_s
}

RED=$(tput setaf 1)
green=$(tput setaf 2)
white=$(tput setaf 7)
reset=$(tput sgr0)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
LOGIN=$(whoami)
VER=$(sed 's/\/.*//' /etc/debian_version | sed 's/\..*//')
VIRT=$(hostnamectl | grep -e "Virtualization" | awk '{print $2}')
RAM=$(free -m | awk '/Mem:/ { print $2 }')

MIRROR="install-bash.pw/install"

install_deb11()
{
	clear
	wget --no-check-certificate $MIRROR/debian11.sh -O /root/debian11.sh
	rm -rf install.sh
	sh debian11.sh
}

install_deb12()
{
	clear
	wget --no-check-certificate $MIRROR/debian12.sh -O /root/debian12.sh
	rm -rf install.sh
	sh debian12.sh
}

install_deb9()
{
	clear
	wget --no-check-certificate $MIRROR/debian9.sh -O /root/debian9.sh
	rm -rf install.sh
	sh debian9.sh
}

menu()
{
	if [ ! $LOGIN = "root" ]; then
		log_n "${RED}Запустите установщик от имени root!"
		exit 1
	fi

	if [ $VIRT = "lxc" ] || [ $VIRT = "openvz" ]; then
		log_n "${RED}Виртуализация ${VIRT} не поддерживается!"
		exit 1
	fi

	if [ $RAM -lt "1024" ]; then
		log_n "${RED}У Вас недостаточно RAM! Минимум 1024 мб."
		exit 1
	fi
	
	clear
	if [ $VER = "9" ]; then
		install_deb9;
	fi
	
	if [ $VER = "11" ]; then
		install_deb11;
	fi
	
	if [ $VER = "12" ]; then
		install_deb12;
	fi
}
menu