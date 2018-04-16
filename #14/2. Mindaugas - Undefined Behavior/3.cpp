// clang++ 3.cpp
// ./a.out
// ./a.out
// ./a.out
// ./a.out
// ./a.out
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>

int main (void)
{
    bool x;
    // use of uninitialized value
    if (x == true ) puts("Hello");
    if (x == false) puts("Goodbye");
    
    return 0;
}
