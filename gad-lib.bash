#  gad-lib.bash is a small bash library providing some rudimentary stuff.
#  Copyright (C) 2018  Gerhard A. Dittes
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Namespace: gad

# Variables

gad_LABEL="gad"

# Functions

gad_log()
{
	local msg="${@}"
	tput setaf 3; printf "[${gad_LABEL}] " >&2; tput sgr0
	tput setaf 7; printf "${msg}\n" >&2; tput sgr0
}

gad_readAndContinue()
{
	local msg="${@}"
	tput setaf 3; printf "[${gad_LABEL}] "; tput sgr0
	tput setaf 7; printf "${msg}"; tput sgr0
	read -p " [RETURN]"
}

gad_question()
{
	local result=1 # false
	local question="${1}"
	local default="n"

	# ensure lowercase
	if [ ${#} -eq 2 ] && [ "${2}" = "y" -o "${2}" = "Y" ]; then
		default="y"
	fi

	tput setaf 3; printf "[${gad_LABEL}] "; tput sgr0
	tput setaf 7; printf "${question}"; tput sgr0

	if [ ${default} = "y" ]; then
		printf " (Y/n): "
	else
		printf " (y/N): "
	fi

	read answer

	# ensure lowercase
	if [ "${answer}" = "Y" ]; then
		answer="y"
	elif [ "${answer}" = "N" ]; then
		answer="n"
	fi

	if [ ${default} = "y" ]; then
		if [ "${answer}" != "n" ]; then
			result=0 # true
		fi
	else
		if [ "${answer}" = "y" ]; then
			result=0 # true
		fi
	fi

	return ${result}
}
