// clang 4.c -O2
// ./a.out

#include <stdlib.h>
#include <stdio.h>


int main(int argv, char *argc[])
{
    int num = atoi(argc[1]);
    
    if (num == 3) {
        printf("not gonna happen");
        // Compilers may generate special instructions in this case (e.g. ud2)
        *((char*)NULL) = 0;
    }
    
    return 0;
}
