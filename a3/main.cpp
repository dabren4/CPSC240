/*=====================================================================================================================
; Copyright 2023 Darren Chen
; This program is free software, you can redistribute it and or modify it
; under the terms of the GNU General Public License version 3
; A copy of the GNU General Public License version 3 is available here: https://www.gnu.org/licenses/
;
; Author Name: Darren Chen
; Author Email: dchen4@csu.fullerton.edu
;
; Program name: Non-Deterministic Random Numbers
; Files in program: main.cpp, executive.asm, fill_random_array.asm, show_array.asm, quicksort.cpp, r.sh
; System requirements: Linux on an x86 machine
; Programming languages: x86 Assembly, C++ and SH
; Date program development began: 3/07/2023
; Date finished: 3/13/2023
; Status: No known errors
;
; Language: x86 Assembly
; No data passed to this module. Module passes string back to main.
;
; Translation information
; Run r.sh script
;
;====================================================================================================================*/

#include <iostream>
#include <cstdlib>

                                                                                                                                                                               extern "C" char * executive();

int main() {
  std::cout << "Welcome to Random Products, LLC\n";
  std::cout << "This software is maintained by Darren Chen\n";
  char *name = executive();
  std::cout << "in main\n";
  std::cout << "Goodbye " << name << ", return zero to Operating System\n";
  return 0;
}
