#==================================
#   Random Numbers
#   Written by Darren Chen
#
#==================================
#
#  How to use:
#   1) navigate to the double-double directory
#   2) run this command: './r.sh'
#
#==================================
#
# compiles/assembles source files to object files

 rm *.o
 rm *.lis
 rm *.out

echo "Compile the C module main.c"
g++ -c -m64 -Wall -no-pie -o main.o main.cpp -std=c++17
#gcc -c -Wall -no-pie -m64 -std=c2x -o main.o main.c

echo "Assemble the executive.asm"
nasm -f elf64 -l executive.lis -o executive.o executive.asm

echo "Assemble the module fill_random_array.asm"
nasm -f elf64 -l fill_random_array.lis -o fill_random_array.o fill_random_array.asm

echo "Assemble the show_array.asm"
nasm -f elf64 -l show_array.lis -o show_array.o show_array.asm

echo "Assemble the quicksort.cpp"
g++ -c -m64 -Wall -no-pie -o quicksort.o quicksort.cpp -std=c++17

echo "Link the 5 object files already created"
g++ -m64 -no-pie -o arrays.out executive.o main.o show_array.o fill_random_array.o quicksort.o -std=c2x

echo "Run the program Assignment 3"
./arrays.out

echo "The bash script file is now closing."

rm *.o
rm *.lis
rm *.out
