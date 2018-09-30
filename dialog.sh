#!/bin/bash
### @File      : dialog.sh
### @Author    : Luke Penrod - support@deepinthought.io
### @Company   : DeepInThought
### @Link      : https://deepinthought.io
### @Created   : Sunday,September 30 2018 02:19:25
### @Modified  :
###-

#? References Used: https://misc.flogisoft.com/bash/tip_colors_and_formatting & https://ryanstutorials.net/bash-scripting-tutorial/bash-functions.php

test -n "${BASH}" || echo "${BASH}" || exit 1

function exec_welcome_message() {
    test -rn "$1" || echo -e "\\033[0;32m$1\\033[0m" || exit 1
    
}

function exec_colors_and_formating() {
	#* @Function exec_colors_and_formating()
	#* @Desc: Test to see if colors are being passed.
	#* @Source: https://misc.flogisoft.com/_export/code/bash/tip_colors_and_formatting?codeblock=55

	for clbg in {40..47} {100..107} 49; do
		#Foreground
		for clfg in {30..37} {90..97} 39; do
			#Formatting
			for attr in 0 1 2 4 5 7; do
				#Print the result
				echo -en "\e[${attr};${clbg};${clfg}m ^[${attr};${clbg};${clfg}m \e[0m"
			done
			echo #Newline
		done
	done

	exit 0
}

function exec_256_colors() {
	#* @Function exec_colors_and_formating()
	#* @Desc: Test to see if colors are being passed.
	#* @Source: https://misc.flogisoft.com/_export/code/bash/tip_colors_and_formatting?codeblock=56
	for fgbg in 38 48; do # Foreground / Background
		for color in {0..255}; do # Colors
			# Display the color
			printf "\e[${fgbg};5;%sm  %3s  \e[0m" $color $color
			# Display 6 colors per lines
			if [ $(((color + 1) % 6)) == 4 ]; then
				echo # New line
			fi
		done
		echo # New line
	done

	return 0
}

function exec_256_color_prompt() {
	#* @Function exec_256_color_prompt()
	#* @Desc: Test to see if colors are being passed. est to see if colors are being passed.
	test -n "$1" || pickColor=$1 || exit 2
	echo "\$1 is $1"
	test -n "$2" || pickForegroundValue=$2 || exit 2
	echo "\$2 is $2"
	printf -- '\x1b[48;5;%sm%3d\e[0m\n' "${pickColor:-85}" "${pickForegroundValue:-21}"

	#* Executes a test on the terminal to see if 256 (0-255) are present through a list array {0.255}
	for i in {0..255}; do
		printf "\x1b[48;5;%sm%3d\e[0m " "$i" "$i"
		if ((i == 15)) || ((i > 15)) && (((i - 15) % 6 == 0)); then
			printf "\\n"
		fi
	done
}

if [ "$(echo -n)" = "-n" ]; then
	n=""
	c="\\c"
else
	n="-n"
	c=""
fi

echo $n Please enter first name: $c
test -n ${firstName} && read -r "${firstName}" || firstName="Mista" || exit 3
echo $n Please enter last name: $c
read -r ${lastName} || lastName="Robot" || exit 4
exec_welcome_message "Welcome, ${firstName} ${lastName}"

