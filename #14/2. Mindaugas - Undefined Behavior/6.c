// clang 6.c
// ./a.out 11
// vs
// clang 6.c -O2
// ./a.out 11

#include <stdio.h>
#include <stdlib.h>

int x (int v, int a)
{
    int r = v < a ? 0 : v-a;
    
    // Division by zero is illegal, so compiler can optimise to
    // int r = v-a;
    
    return r;
}


int main(int argv, char *argc[])
{
    int a = atoi(argc[1]);
    
    // division by zero
    printf("result %d \n", 1000/x(10, a));
    
    return 0;
}
