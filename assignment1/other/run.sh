#!/bin/bash

#==================================
#   Pythagoras
#   Written by Darren Chen
#==================================

# Clear any previously compiled outputs
rm *.o
rm *.out

# compiles/assembles source files to object files
nasm -f elf64 -o pythagoras.o pythagoras.asm

echo "compile driver.cpp using g++ compiler"
g++ -c -m64 -Wall -no-pie -o driver.o driver.cpp -std=c++17

echo "link object files using the g++ linker"
g++ -m64 -no-pie -o output driver.o pythagoras.o -std=c++17
#
#links files into a binary
#g++ -g -Wall -no-pie driver.o isfloat.o pythagoras.o  -o output
#
# runs binaries
./output


echo "Run the Pythagoras Program:"
./pythagoras.out

# cleanup
rm *.lis
rm *.o
rm *.out

echo "Script file terminated."
