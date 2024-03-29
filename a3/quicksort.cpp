extern "C" void quicksort(double[], int);

void quicksort(double numbers[], int array_size)
{
  int i, j;
  int min, temp;

  for (i = 0; i < array_size - 1; i++)
  {
    min = i;
    for (j = i + 1; j < array_size; j++)
    {
      if (numbers[j] < numbers[min])
        min = j;
    }
    temp = numbers[i];
    numbers[i] = numbers[min];
    numbers[min] = temp;
  }
}
