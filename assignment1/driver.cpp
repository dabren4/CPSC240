#include <iostream>
#include <cstdio>

extern "C" double pythagoras();

int main(int argc, char *argv[])
{
  double hypot = 0.0;
  printf("%s\n", "Welcome to Pythagoras' Math Lab programmed by Darren Chen.");

  printf("%s\n", "Please contact me at dchen4@csu.fullerton.edu if you need assistance.");



  hypot = pythagoras();

  printf("The main function has received this number %1.12lf and has decided to keep it. \n", hypot);

  return 0;
}
