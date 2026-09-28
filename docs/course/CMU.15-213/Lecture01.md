# Lecture 01 Course Overview

Great Reality #1:
> Ints are not Integers, Floats are not Reals
Example 1: Is $ x^2\geq 0 $ ?

- Floats: Yes
- Ints: No

```sh
(gdb) print 40000 * 40000
$1 = 1600000000
(gdb) print 50000 * 50000
$2 = -1794967296
(gdb)  // unix paralleled lldb
```

Example 2: Is (x + y) + z = x + (y + z) ?

- Unsigned & Signed Ints: Yes
- Floats: No

(1e20 + -1e20) + 3.14 = 3.14
-1e20 + (1e20 + 3.14) = ??

Great Reality #2:

> You've Got to Know Assembly
x86-64
Great Reality #3:
> Memory matters
Memory Reference Bug Example

```c
typedef struct {
  int a[2];
  double d;
} struct_t;

double fun(int i) {
  volatile struct_t s;
  s.d = 3.14;
  s.a[i] = 10048950  /* Possibly out of bounds */
  return s.d;
}
```

Great Reality #4:
> There's more to performance than asymptotic complexity

Copy i, j, row by row; column by column.
4.3ms vs 81.8ms

Great Reality #5:
> Computers do more than execute programs
