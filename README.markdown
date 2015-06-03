# Doubly-prime curves: Numerical results

Let `F_p` be a finite field over a prime `p`, and
`E_j(F_p)` be the elliptic curve defined by:

    y^2 = x^3 + 36*x/(j0 - 1728) + -1*(j0 - 1728)

We consider the "Solinas primes",

    P_224 = N^7 - N^3 + N^0
    P_256 = N^8 - N^7 + N^6 + N^3 - N^0
    P_384 = N^12 - N^4 - N^3 + N^1 - N^0

where `N = 2^32`,

the nearly-Mersenne prime

    M255 = 2^255 - 19

and the Hamburg prime

    H448 = 2^448 - 2^224 - 1

--

For each of these primes, we calculate the trace, `T_f`,
of each non-singular `K_j = E_j(F_p)` curve
(`j != 0, 1728`) for `j < 2^20` and `#K_j`
prime.

Noting that the number of points on the curve and 
its twist are given by

    #K   = p - T_f + 1
    #K^t = p + T_f + 1

the number of prime and doubly-prime curves in the
interval `0 < j < 2^20` are given by:

    | p     | pri    | pri'   | p(p'|p)/100 | 
    |-------|--------|--------|-------------|
    | P224  |   2790 |     31 |        1.11 |
    | P256  |   1956 |     15 |        0.77 |
    | P384  |   1131 |     20 |        1.77 |
    | M255  |        |        |             |
    | H448  |        |        |             |


      N^   0  1  2  3  4  5  6  7  8  9  10 11 12
    P224  +1       -1          +1
    P256  -1       +1       +1 -1 +1
    P384  -1 +1    -1 -1                       +1


--

sol-like primes that are 3 mod 4:
2^384 - 2^128 - 2^96  + 2^32  - 1
2^384 - 2^224 - 2^160 + 2^32  - 1
2^384 - 2^288 + 2^192 - 2^32  - 1
2^384 - 2^288 + 2^64  + 2^32  - 1
2^384 - 2^320 + 2^192 + 2^128 - 1
2^384 - 2^320 + 2^288 - 2^160 - 1
2^384 - 2^320 + 2^288 - 2^96  - 1
2^384 - 2^352 + 2^224 + 2^64  - 1
```pari
sol_like = [2^384 - 2^128 - 2^96  + 2^32  - 1,
            2^384 - 2^224 - 2^160 + 2^32  - 1,
            2^384 - 2^288 + 2^192 - 2^32  - 1,
            2^384 - 2^288 + 2^64  + 2^32  - 1,
            2^384 - 2^320 + 2^192 + 2^128 - 1,
            2^384 - 2^320 + 2^288 - 2^160 - 1,
            2^384 - 2^320 + 2^288 - 2^96  - 1,
            2^384 - 2^352 + 2^224 + 2^64  - 1]
```
