# P-384

Perform the following experiment, described in Sage pseudocode:

```
p = 2^384 - 2^128 - 2^96 + 2^32 - 1
F384 = GF(p)
for j0 in generated_j0s:
  j = j0 - 1
  elliptic_twin = False
  while not elliptic_twin:
    j += 1
    E = EllipticCurve_from_j0(F384(j))
    tf = E.trace()
    nE = p - tf + 1
    nT = p + tf + 1
    elliptic_twin = isprime(nE) and isprime(nT)
  # write output
```

The `generated_j0s` were generated using a [Go script](https://github.com/coruus/elliptic-twin-curves/blob/master/genrandom/genrandom.go), and may be found
in [P-384.txt](https://github.com/coruus/elliptic-twin-curves/blob/master/sol384d2/misc/P-384.txt)

## Reference list

- ["SafeCurves: Twist security"](http://safecurves.cr.yp.to/twist.html)

- ["S. D. Galbraith, J. F. McKee, The probability that the number of points on an elliptic curve over a finite field is prime. 2000."](https://www.math.auckland.ac.nz/~sgal018/cm.pdf)

- ["Shparlinski I and Sutantyo D. Distribution of elliptic twin primes in isogeny and isomorphism classes. 2014"](http://www.researchgate.net/publication/259506269_Distribution_of_elliptic_twin_primes_in_isogeny_and_isomorphism_classes)

- ["[curves] Twist security and induced distributions"](https://moderncrypto.org/mail-archive/curves/2014/000336.html)


## Results

These results, though they are a relatively large sample of curves
reduced over P-384, are incomplete: They are the first 411 of a set
of 1000. (Which is unlikely to be completed due to resource constraints.)

Please don't try to interpret the data too much. (It is probably biased
against very large gaps between elliptic twins in j-invariant; and some
gaps have taken nearly a week to explore.)

--

Running

    grep deltaj *.jx | cut -d ':' -f3  | tr -s '\n' ' '

to extract the stopping times, and letting

```py
stopping_times = [
 0x19371, 0x34d4a, 0x61bd, 0x84af, 0xa7eb, 0x51e9c, 0x43646, 0xc61, 0x16f79, 0x415, 0x192ce, 0x14750, 0xc96, 0x12b42, 0x1b180, 0x30d38, 0x57dc, 0x21b7c, 0x2895, 0x75b4, 0x1fa9b, 0xc9ee, 0xba8e, 0x14788, 0x152aa, 0x162d7, 0x841d, 0x1235a, 0xb590, 0x11f02, 0x5b41, 0x1d01a, 0x6d8, 0x4469e, 0x97c6, 0x63ce, 0x22741, 0x1006c, 0x2f6d2, 0x34cc8, 0xb27, 0x147e1, 0x14b66, 0x3333c, 0x10863, 0x1813, 0x11d10, 0x16971, 0x1287d, 0x9716, 0xe90b, 0x50a2, 0x4424, 0x26ca, 0x147f1, 0x1b131, 0x8a7d, 0x101f8, 0x3310, 0xcef7, 0x6182, 0x628b, 0xed20, 0x212a3, 0x201e7, 0xa997, 0x3a10f, 0x1edfa, 0x34c9e, 0x77bc, 0x1fe8, 0x1dd91, 0x78f33, 0x20fe8, 0x1a2ce, 0x15a5, 0x1dc5, 0x1abda, 0xc9d7, 0x1888e, 0x2160, 0x3bf7, 0xa94c, 0xceef, 0xdd30, 0xdb3f, 0x9097, 0x128fa, 0x12a88, 0x8010, 0x57aa8, 0x21b, 0x58309, 0x134, 0x2ebf, 0x3a43, 0x47417, 0x50849, 0x2cf21, 0x4ede0, 0x2b7e2, 0x2eba2, 0x3d967, 0x2a840, 0x318e7, 0x1b9f9, 0x146fe, 0x301f8, 0x17f90, 0x1a7cb, 0x39b31, 0x1ded4, 0xb137, 0x44be, 0x10c22, 0x445b, 0xa40e, 0x3bac, 0x41bd, 0x176e1, 0x23bc6, 0xb7f4, 0xae4d, 0x5fcb, 0xb9f, 0x3ed35, 0x321a0, 0xb24a, 0x179e5, 0x4c35, 0x199, 0x1a990, 0x1c0d9, 0x128c9, 0x16663, 0x8fba, 0x893e, 0x1621b, 0x3fa4b, 0x18f6e, 0x294a5, 0x17929, 0x31d1c, 0x22ac, 0x284ee, 0x170ec, 0x33995, 0x364f, 0x3a339, 0xe877, 0x1696d, 0x17500, 0x269c3, 0x2693e, 0x10da5, 0xe0a5, 0x11f7c, 0x4121, 0x2774f, 0x1666b, 0xb4d5, 0x13596, 0xcf8f, 0xecab, 0x17585, 0x7b86, 0xf9f5, 0x2fed, 0x101a2, 0x11bbd, 0x1c463, 0xe0f3, 0x660f, 0x5d5b, 0x13b4f, 0xb5af, 0xf7b, 0x4557]

float(len(stopping_times)) / sum(stopping_times)
> 1.0644038477361923e-05
```

which is a (bad) estimator for the probability of a randomly selected
curve being an elliptic twin. (It is *not* the probability, given
that a curve has prime order, of that curve being an elliptic twin.)

--

Bootstrapping gives, for 0.01, 0.05, 0.99 of medians:

    508, 574, 638
    57380, 73535, 84925

which gives 0.005 to 0.011 by interval arithmetic. This is still
rather uselessly large for the question of evaluating the asymptotic
expression of ShparSutantyo2014 in this range.

--

This data is more useful for estimating the number of curves that need
to be examined in order to find an elliptic twin, as a rough metric for
the amount of computation needed to achieve a target sample size.

    print("""\
    max(gap): {}
    mdn(gap): {}
    """.format(max(stopping_times), np.median(stopping_times))

    max(gap): 495411
    mdn(gap): 73535.0
