// see clang vs gcc https://godbolt.org/g/BAWiUZ

#include <stdio.h>

//   it is legal to optimise it to:
//   void x(int *a)
//   {
//       *a = 3;
//   }
void x(int *a)
{
    // 1) pointer derefence
    int dead = *a;
    
    // 2) redundant NULL check
    if (a == NULL) {
        // 3) Because of 1) compilers can assume that this never happens
        printf("NULL!\n");
        return;
    }
    
    *a = 3;
}

int main()
{
    x(NULL);
}
