# py2c

py2c is a script that allows you to automatically compile python into natively executable binaries!

Normally, compiling python files into binaries can be difficult and confusing. However, py2c automates this process and allows for easy compilation into binaries.


## Installation:

py2c does not require installation as it is a simple shell script. However, py2c requires both [Cython](https://github.com/cython/cython) and python (either python2 or python3 is acceptable). It also requires a c compiler which is called via the `cc` comand.

To install Cython, python must first be installed. Afterwards, Cython can be installed with the command `pip install Cython`.

To use py2c out of its git directory, copy it to a directory in your `PATH`. Preferably copy it without the file extension `.sh` to call py2c as `py2c ...` as opposed to `py2c.sh ...`.


## Usage:

After installing all dependencies, py2c can now be used. If py2c is in your `PATH`, you can call it with `py2c`. Otherwise, you will call it via `./py2c.sh`.

To compile a python3 file into a binary: `py2c -o file file.py`

To compile a python2 file into a binary: `py2c -2 -o file file.py` or `py2c --python2 -o file file.py`

To keep the c file made by Cython: `py2c -o file file.py -k` or `py2c -o file file.py --keep`

If you need any help with the command line options, run `py2c -h` or `py2c --help`

To test out py2c immediatly, cd into examples. From there, test out the hello world program by executing `py2c -o helloworld helloworld.py`. Rn the compiled file with `./helloworld`, et voila.


## Troubleshooting:

On the event a python file does not compile, carefully read the error message and from which program the error message originates. Often times, the c linker will throw a bunch of errors if a specific library is not linked. For now, the only remedy is to manually edit the py2c shell file to include the linker command for the specific library.

If you cannot solve your issue, feel free to open an issue on the github [issue board](https://github.com/Raniconduh/py2c/issues)

