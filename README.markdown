# Soleil

Distribution of the orders of twists of prime-order curves:
Numerical results


Let `F_p` be a finite field over a prime `p`, and
`E(j)/F_p` be the elliptic curve defined by:

    y^2 = x^3 + 36*x/(j0 - 1728) + -1*(j0 - 1728)

We consider the "Solinas primes" (where `N = 2^32`)

    P_224 = N^7 - N^3 + N^0
    P_256 = N^8 - N^7 + N^6 + N^3 - N^0
    P_384 = N^12 - N^4 - N^3 + N^1 - N^0,

and the Mersenne prime `M_521`:

    M_521 = 2^521 - 1.

--

For each of these primes, we calculate the trace, `T_f`,
of each non-singular `K_j = E(j)/F_p` curve
(`j != 0, 1728`) for `j < 2^20` and `#K_j`
prime.

Noting that the number of points on the curve and 
its twist are given by

    #K   = p - T_f + 1
    #K^t = p + T_f + 1

the number of prime-order curves and doubly-prime-order
curves in the interval `j < 2^20` are given by:

    | p     | prime  | doubly prime | p / 1e-3
    |-------|---------------------------------
    | P224  |  
    | P256  |  1956  |         15   | 0.767  |
    | P384  |   



      N^   0  1  2  3  4  5  6  7  8  9  10 11 12
    P224  +1       -1          +1
    P256  -1       +1       +1 -1 +1
    P384  -1 +1    -1 -1                       +1
