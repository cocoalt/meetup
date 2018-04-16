// clang++ 5.cpp
// gcc vs clang https://godbolt.org/g/sRzrrG
// ./a.out 2
// vs
// ./a.out 3
#include <stdio.h>
#include <stdlib.h>

int main(int argv, char *argc[])
{
    int arg = atoi(argc[1]);
    bool *predicate = (bool *)&arg;
    // Invalid bool value
    if (*predicate) {
        puts("True");
    } else {
        puts("False");
    }
    
    return 0;
}
