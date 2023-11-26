#include <stdio.h>
#include <stdlib.h>

int main() {
  // Declare a local variable
  int x = 10;

  // Allocate memory on the heap for an object
  int* y = malloc(sizeof(int));
  *y = 20;

  // Use the local variable and the object
  printf("x = %d, y = %d\n", x, *y);

  printf("x -> %p, y -> %p\n", &x, y);
  // Deallocate memory on the heap for the object
  free(y);

  return 0;
}
