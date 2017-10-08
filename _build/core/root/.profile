cd
export HOME=$PWD
export USER=$(whoami)
printf "\e[43;37m GEAR%s/%s root@$(hostname) \e[0m\n" $(cat /etc/version) $(cat /etc/release)
test -n "$OS_MODE" &&
export PS1="\e[1;37;43m $OS_MODE:\e[30m\w\e[37m: \e[0m " ||
export PS1="\e[1;37;43m $(cat /etc/version):\e[30m\w\e[37m: \e[0m "
