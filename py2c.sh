#!/bin/sh

help() {
	echo "py2c - create and compile a C file using Cython"
	echo ""
	echo "Usage: py2c.sh [options] file.py"
	echo "Options:"
	echo "  -o, --output-file <filename>		Specify name of output file"
	echo "  -2, --python2				Use python2 standards"
	echo "  -3, --python3				Use python3 standards"
	echo "  -k, --keep				Do not delete the generated C or C++ file"	
	exit $1
}


if [ $# -lt 1 ]; then
	echo "Error: No arguments given"
	help 1
fi


file=""
output_file="a.out"
python_type="-3"
python_version="0"
keep=0

while test $# -gt 0; do
	case "$1" in
		-h|--help)
			help 0
			;;
		-o|--output-file)
			output_file=$2
			;;
		-2|--python2)
			python_type="-2"
			;;
		-3|--python3)
			python_type="-3"
			;;
		-k|--keep)
			keep=1
			;;
		*.py)
			file=$1
			;;
	esac
	shift
done

c_file_name=$file".c"
cython --embed -o $c_file_name $python_type $file


if [ $output_file = "a.out" ]; then
	output_file=$file".out"
fi


if [ $python_type = "-2" ]; then
	python_version=$(python2 -c 'import platform; print(platform.python_version());' | cut -c 1-3)
	CFLAGS=$(python2-config --cflags)
	LIBS=$(python2-config --libs)
elif [ $python_type = "-3" ]; then
	python_version=$(python3 -c 'import platform; print(platform.python_version());' | cut -c 1-3)
	CFLAGS=$(python3-config --cflags)
	LIBS=$(python3-config --libs)
fi


cc -Os $CFLAGS -o $output_file $c_file_name -lpython$python_version $LIBS -fPIE

if [ $keep = 0 ]; then
	rm $c_file_name
fi

exit 0

