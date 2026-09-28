# Lecture 02 Bits, Bytes and Integers

Everything is bits.

## Boolean Algebra

- And  & Intersection
- Or | Union
- Not ~ Complement
- Exclusive-Or(XOR) ^ Symmetic difference

## Shift Operations

- Left Shift: x << y
- Right Shift: x >> y
  - Logical
  - Arithmetic

```c
char x = 56;
x = x << 8;
printf("%d\n", x);  // get 0
```

## Encoding Integers

Two's Complement

```sh
1011 = -8 + 2 = -6
1111 = -8 + 4 + 2 + 1 = -1
```
