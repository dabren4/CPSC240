//****************************************************************************************************************************
// Program name: "Pythagoras".  This program takes in the user input of height and width in float and calculates perimeter and
// average side length. Copyright (C) 2023 Darren Chen.                                                                       *
//                                                                                                                           *
// This file is part of the software program "Pythagoras".                                                                   *
// Pythagoras is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
// version 3 as published by the Free Software Foundation.                                                                    *
// Pythagoras is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
// A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
//****************************************************************************************************************************

//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
// Author information
//  Author name: Darren Chen
//  Author email: darrenxychen@gmail.com
//
// Program information
//  Program name: Darren Chen
//  Programming languages: One modules in C++ and one module in X86
//  Date program began: 2023 Jan 28
//  Date of last update: 2023 Feb 06
//  Files in this program: driver.cpp, pythagoras.asm
//  Status: Finished.
//
// Purpose
//  Show how to input and output floating point (64-bit) numbers.
//
// This file
//   File name: driver.cpp
//   Language: C++
//   Max page width: 132 columns
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//
//===== Begin code area ===========================================================================================================
#include <iostream>
#include <cstdio>

extern "C" double pythagoras();

int main(int argc, char *argv[])
{
  printf("%s\n", "Welcome to Pythagoras' Math Lab programmed by Darren Chen.");

  printf("%s\n", "Please contact me at dchen4@csu.fullerton.edu if you need assistance.");

  printf("The main function has received this number %1.12lf and has decided to keep it. \n", pythagoras());

  return 0;
}
