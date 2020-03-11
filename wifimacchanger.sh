#!/bin/bash
clear
echo -e "\033[5;41;30mThis program requires sudo privileges to run\033[0m"
echo
echo
echo -e "\033[1;31;40mPlease enter password for sudo privileges\033[0m"
sudo echo
clear
echo
echo
echo
echo -e "\033[1;44;30m                     Mac OSX Host Name and MAC address                     \033[0m"
echo -e "\033[44;30m                                                                           \033[0m"
echo -e "\033[44;31m ██▀███  ▄▄▄      ███▄    █ ▓█████▄  ▒█████   ███▄ ▄███▓ ██▓▒███████▒▓█████\033[0m"
echo -e "\033[44;31m▓██ ▒ ██▒████▄    ██ ▀█   █ ▒██▀ ██▌▒██▒  ██▒▓██▒▀█▀ ██▒▓██▒▒ ▒ ▒ ▄▀░▓█   ▀\033[0m"
echo -e "\033[44;31m▓██ ░▄█ ▒██  ▀█▄ ▓██  ▀█ ██▒░██   █▌▒██░  ██▒▓██    ▓██░▒██▒░ ▒ ▄▀▒░ ▒███  \033[0m"
echo -e "\033[44;31m▒██▀▀█▄ ░██▄▄▄▄██▓██▒  ▐▌██▒░▓█▄   ▌▒██   ██░▒██    ▒██ ░██░  ▄▀▒   ░▒▓█  ▄\033[0m"
echo -e "\033[44;31m░██▓ ▒██▒▓█   ▓██▒██░   ▓██░░▒████▓ ░ ████▓▒░▒██▒   ░██▒░██░▒███████▒░▒████\033[0m"
echo -e "\033[44;31m░ ▒▓ ░▒▓░▒▒   ▓▒█░ ▒░   ▒ ▒  ▒▒▓  ▒ ░ ▒░▒░▒░ ░ ▒░   ░  ░░▓  ░▒▒ ▓░▒░▒░░ ▒░ \033[0m"
echo -e "\033[44;31m  ░▒ ░ ▒░ ▒   ▒▒ ░ ░░   ░ ▒░ ░ ▒  ▒   ░ ▒ ▒░ ░  ░      ░ ▒ ░░░▒ ▒ ░ ▒ ░ ░  \033[0m"
echo -e "\033[44;31m  ░░   ░  ░   ▒     ░   ░ ░  ░ ░  ░ ░ ░ ░ ▒  ░      ░    ▒ ░░ ░ ░ ░ ░   ░  \033[0m"
echo -e "\033[44;31m   ░          ░  ░        ░    ░        ░ ░         ░    ░    ░ ░       ░  \033[0m"
echo -e "\033[44;31m                             ░                              ░              \033[0m"
echo "                                By: Paradox"
echo
echo
read -p "Press enter to continue"
clear

PS3='Please select a function from the list: '
options=("Randomize WiFi MAC Address" "Randomize Host Name" "Flush DNS Cache - Do this last" "Quit")
select opt in "${options[@]}"
do
	case $opt in
		"Randomize WiFi MAC Address")
			sudo ifconfig en0 up;
			sudo openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//' | xargs sudo ifconfig en0 ether;
			sudo ifconfig en0 down;
			sudo ifconfig en0 up;
			macOutput="$(ifconfig en0 | grep ether)";
			echo "Your new MAC address is: ${macOutput}"
			;;
		"Randomize Host Name")
			name="$(openssl rand -hex 8)";
			sudo scutil --set HostName $name;
			sudo scutil --set ComputerName $name;
			sudo scutil --set LocalHostName $name;
			hName="$(scutil --get HostName)";
			echo "Your new Host Name is:${hName}"
			;;
		"Flush DNS Cache - Do this last")
			sudo dscacheutil -flushcache;
			echo "DNS cache has been flushed."
			;;
		"Quit")
			break
			;;
		*) echo "invalid option $REPLY";;
	esac
done

clear

echo "If you just changed your computer name and flushed your DNS cache,"
echo "it might also be wise to restart your computer and randomize the"
echo "MAC address a second time."
echo
read -p "Press enter key to close the terminal window"
exit 0
