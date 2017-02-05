#!/bin/bash
#  bytebeat.sh
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#
#  Source http://coleingraham.com/2013/04/28/bytebeat-shell-script/
#  
# This script creates and plays a simple ByteBeat
# ARGS
# $1: a string with the ByteBeat algorithm e.g. "((t * 3) & (t >> 5))"
# $2: the name of the file to be creates (without an extension)
#
###
error1="\nYou must enter two arguments\n
a string with the ByteBeat algorithm (with quotes) \n
and the name of the file to be creates (without an extension)\n
ex: ./bytebeat.sh algorithm files\n"

if (($# > 3)); then
	echo -e $error1
	echo $#
	exit 100
elif [ $# -le 1 ]; then
	echo -e $error1
	echo $#
	exit 101
else
# make the c file
echo "main(t) {
for( t = 0;;t++)
putchar( $1 );
}" > "$2.c"
###
# compile the source
gcc "$2.c" -o "$2"
rm "$2.c"
###
# play it with standard ByteBeat settings
./"$2" | sox -c 1 -e unsigned-integer -r 8000 -t u8 - -d --buffer 32
fi
exit 0
