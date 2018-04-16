
#include <stdio.h>

// optimise to return 0
int foo(int x)
{
    int a;
    if (x) {
        //this is UB, so can never happen
        return a;
    }
    return 0;
}

int main()
{
    printf("%d\n",foo(2));
}
