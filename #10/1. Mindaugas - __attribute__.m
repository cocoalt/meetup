#import <Foundation/Foundation.h>

#pragma mark - __attribute__((deprecated))
void old(void)__attribute__((deprecated));

void old(){};

@interface SweetBrown : NSObject
- (void)fire __attribute__((deprecated("Oh, Lord Jesus, it's a fire!", "aintnobodygottimeforthat"))) ;
- (void)aintnobodygottimeforthat;
@end

__attribute__((deprecated("Classes can be deprecated too!")))
@interface OldClass : NSObject
@end

@implementation SweetBrown
- (void)fire __attribute__((deprecated("Oh, Lord Jesus, it's a fire!", "aintnobodygottimeforthat"))) {};
- (void)aintnobodygottimeforthat {};
@end
@implementation OldClass
@end

void demo1(){
    old();
    [[SweetBrown new] fire];
    NSLog(@"%@", [[OldClass alloc] init]);
}

#pragma mark - __attribute__((availability))
void not_available(void) __attribute__((availability(ios,unavailable)));

@interface X :NSObject
- (instancetype)init __attribute__((unavailable("Use initWithString")));
- (instancetype)initWithString:(NSString *)string;
@end

void demo2(){
    //    not_available();
    //    X *x = [[X alloc] init];
}

#pragma mark - __attribute__((alloc_size()))

void *my_malloc(size_t n) __attribute__((alloc_size(1))) { return malloc(n);}
void *my_malloc2(size_t n, size_t c) __attribute__((alloc_size(1,2))) { return malloc(n * c);};

void demo3() {
    void *const five = my_malloc(5);
    void *const six = my_malloc2(2,3);
    
    
    strncpy(five, "abcdefaa", 6);
    memcpy(six, "1234567", 7);
}

#pragma mark - __attribute__((noreturn))
void point_of_no_return(void) __attribute__((noreturn)) {while (1);};

void demo4(){
    point_of_no_return();
    NSLog(@"Move along..");
}

#pragma mark - __attribute__((diagnose_if()))
typedef enum {
    day_one,
    day_two
} days;

void judgement_day(days a) __attribute__((diagnose_if(a>day_two && a<= 5,"The future is not set","warning"))) __attribute__((diagnose_if(a > 5,"Skynet becomes self aware!","error")));
void judgement_day(days a) {};

void judgement_day2(int a) __attribute__((enable_if(a == day_one || a == day_two,"Shutting down!"))) {};


void demo5(){
    judgement_day(day_one);
    judgement_day(day_two+1);
    judgement_day(1);
    //    const int a = 6;
    //    judgement_day(a);
    
    judgement_day2(1);
    //    judgement_day2(4);
}

#pragma mark - __attribute__((__format__))

void my_log(NSString *format, int some_param, ...) __attribute__((format(__NSString__,1,3)));
void my_log(NSString *format, int some_param, ...) {};

void demo6()
{
    my_log(@"A %@", 1, @"Message");
    my_log(@"B %d", 2, @"Message");
    my_log(@"C %d %d", 3, 1);
}

#pragma mark - __attribute__((no_sanitize("address")))

void demo7 () __attribute__((no_sanitize("address")))
{
    char a[5];
    strcpy(a, "123456");
}

#pragma mark - __attribute__((objc_boxable))

void demo8() {
    typedef struct __attribute__((objc_boxable)){
        int x, y;
    } coordinate;
    coordinate origin = {1,1};
    
    NSValue *v = @(origin);
    NSLog(@"%@", v);
    
    coordinate origin2;
    [v getValue:&origin2];
    NSLog(@"%d, %d", origin2.x, origin2.y);
}

#pragma mark - __attribute__((objc_requires_super))

@interface SweetBrown (requires_super)
- (void)star __attribute__((objc_requires_super));
@end

@interface Sugar : SweetBrown
@end

@implementation Sugar

- (void)star
{
    
}

@end

#pragma mark - __attribute__((overloadable))

void __attribute__((overloadable)) overloaded(NSString *);
void __attribute__((overloadable)) overloaded(NSData *);

void __attribute__((overloadable)) overloaded(NSString *string)
{
    NSLog(@"String: %@", string);
}
void __attribute__((overloadable)) overloaded(NSData *data)
{
    NSLog(@"Data: %@", data);
}


void demo10() {
    overloaded([@"AAAA" dataUsingEncoding:NSUTF8StringEncoding]);
    overloaded(@"AAAA");
}

#pragma mark - __attribute__((warn_unused_result))

int meaning_of_life(void) __attribute__((warn_unused_result));
int meaning_of_life(void) {return 42;};

@interface SweetBrown (warn_unused_result)
+ (BOOL)escape_fire __attribute__((warn_unused_result));
@end
@implementation SweetBrown (warn_unused_result)
+ (BOOL)escape_fire {return YES;}
@end

void demo11() {
    meaning_of_life();
    [SweetBrown escape_fire];
}

#pragma mark - __attribute__((unused))

void demo12() {
    int a __attribute__((unused)) = 0;
    int b = 1;
}

#pragma mark - __attribute__((objc_subclassing_restricted))

__attribute__((objc_subclassing_restricted))
@interface DarthVader : NSObject

@end

//@interface Luke : DarthVader
//@end

#pragma mark - __attribute__((cleanup()))

void mycleanup(char **x)
{
    NSLog(@"Freeing.. %p", *x);
    free(*x);
}

void demo14_1()
{
    char *x __attribute__((cleanup(mycleanup))) = malloc(10);
    if (!x) {
        return;
    }
    
    char *y __attribute__((cleanup(mycleanup))) = malloc(20);
    if (!y) {
        return;
    }
    
    //Do some work
    NSLog(@"Some Work");
}


static void __attribute__((unused)) defer_cleanup_block(__strong void(^*block)(void)) {
    (*block)();
}
#define __concat(prefix, suffix) prefix ## suffix
#define __cleanup_block_(suffix) __concat(__cleanup_block, suffix)
#define defer __strong void(^__cleanup_block_(__LINE__))(void) __attribute__((cleanup(defer_cleanup_block),unused))  = ^

void demo14_2()
{
    char *x = malloc(10);
    defer {
        NSLog(@"freeing x!");
        free(x);
    };
    
    if (!x) {
        return;
    }
    
    char *y = malloc(20);
    defer {
        NSLog(@"freeing y!");
        free(y);
    };
    
    if (!y) {
        return;
    }
    
    //Do some work
    NSLog(@"Some Work");
}

#pragma mark - __attribute__((constructor))

void __attribute__((constructor)) my_init()
{
    demo1();
    demo2();
    
    // "detected buffer overflow" crash at runtime
    //  demo3();
    
    // no return
    //    demo4();
    demo5();
    demo6();
    demo7();
    demo8();
    
    demo10();
    demo11();
    demo12();
    
    demo14_1();
    demo14_2();
}
