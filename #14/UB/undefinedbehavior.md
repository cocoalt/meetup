# [fit] Undefined Behavior

---

# Undefined Behavior

- behavior, upon use of a nonportable or erroneous program construct or of erroneous data, for which this International Standard imposes no requirements


- Your code has correct syntax, but it's behaviour is not within the bounds that language specification allows us.

---

# Examples

:bug: *Integer Overflow* :bug: *Division by Zero* 
:bug: *Out-of-Bounds Array Access* :bug: *Invalid Shift*
:bug: *NULL dereference* :bug: *Use of uninitialised values* 
:bug: *Access to an object past end of lifetime* 
:bug: *Misaligned Pointers* :bug: *Missing return statement* 
 

---

# Why

* Performance over safety
* Historical reasons
* Portability

---

# Compiler and Undefined Behavior

* Ignore the situation completely with unpredictable results!
* Behaving in a documented manner 
* Terminating compilation or execution 
* Provides information, e.g.:
 *NULL cannot be dereferenced
 *Signed integers cannot overflow


---

# Issues with Undefined Behavior

* Undefined behavior is unpredictable
* Bugs may be dormant for years
* No Reliable Way to Determine if a Large Codebase Contains Undefined Behavior
* Undefined behavior and security do not mix well

---

# What we can do about it

* Pay attention to warnings
* Run static analyzer
* Use runtime sanitizers
* Use safe language/constructs (swift, NSArrays)

---

https://godbolt.org/g/oGyd5w
https://godbolt.org/g/BAWiUZ
https://godbolt.org/g/r49amQ
https://godbolt.org/g/sRzrrG
https://godbolt.org/g/U2GpBN
https://godbolt.org/g/7FWmSq

---

# References

- [C standard](http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1570.pdf)
- [Compiler Explorer](https://godbolt.org)
- [Undefined Behavior Sanitizer](https://clang.llvm.org/docs/UndefinedBehaviorSanitizer.html)
