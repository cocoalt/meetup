// clang 1.c
// ./a.out
// vs
// clang 1.c -O2
// ./a.out

#include <stdio.h>

static void (*f)() = NULL;


void format_your_disk()
{
    printf("Chomp chomp... \n");
}

void x()
{
    f = format_your_disk;
}

int main()
{
    // NULL Pointer dereference
    f();
}
