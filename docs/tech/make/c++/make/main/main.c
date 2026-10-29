#include <stdio.h>

#include "max.h"
#include "min.h"

int main(void)
{
    int a = 12;
    int b = 34;
    int arr[] = {5, 4, 6, 3, 8};
    int len = (int)(sizeof(arr) / sizeof(arr[0]));

    printf("max = %d\n", max(arr, len));
    printf("min = %d\n", min(arr, len));
    printf("sum = %d\n", a + b);
    printf("Hello, C World!\n");

    return 0;
}

// gcc -S hello.c
