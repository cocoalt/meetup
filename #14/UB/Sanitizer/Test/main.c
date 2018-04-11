#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

// "safe" :)
void *safe_string_malloc (int size) {
    // signed integer overflow
    if (size > size+1)
        abort();
    
    char *string = malloc(size+1);
    
    return string;
}

int main()
{
    printf("%p\n", safe_string_malloc(INT_MAX));
}

