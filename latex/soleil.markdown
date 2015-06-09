Preface
=======

This is a preliminary note of some numerical experiments; the results may be rather wrong.

Introduction
============

Twist-secure curves for elliptic curve cryptography are much in vogue these days; and others have proposed that twist-security is an essential safety condition for choosing curves.

 cites as introducing the so-called “unsafe-twist” attack,f but I have been unable to find any evidence either there or in his (quite excellent) thesis, , that he was aware of this attack.

Elliptic twin curves
====================

We follow the definitions of , with some minor modifications.

Let \({\ensuremath{\BbbE_j} }\) be the elliptic curve of invariant \(j\), and \({\ensuremath{\BbbE_j(\BbbF_q)} }\) be its reduction over a finite field of characteristic \(p > 5, n \geq 1\) with \(p\) prime. Let and \(t({\ensuremath{\BbbE_j(\BbbF_q)} })\) be the trace of Frobenius of that elliptic curve.

Let \({\ensuremath{\widetilde{\BbbE}_j(\BbbF_q)} }\) be the non-trivial quadratic twist of \({\ensuremath{\BbbE_j(\BbbF_q)} }\) over the same field.

An *elliptic twin* is a pair consisting of a prime \(p\), and two primes not equal to \(p\) or \(0\), \((p, {l, r})\) such that

\[\#{\ensuremath{\BbbE_j(\BbbF_p)} }\#{\ensuremath{\widetilde{\BbbE}_j(\BbbF_p)} }= l + r = 2 p + 2 - l + r\]

It is clear that there exist elliptic twins over arbitrary prime fields, but the formulae of are not amenable to characterizing local fluctuations in the density of such elliptic twins holding the finite field fixed.

Primes
======

We consider the non-Mersenne SECP primes, standardized for the use of the federal government in , which are, where \(N \coloneqq 2^{32}\):

\[\begin{aligned}
    {\ensuremath{\mathup{P}_{224}} }&= N^7 - N^3 + N^0                \\
    {\ensuremath{\mathup{P}_{256}} }&= N^8 - N^7 + N^6 + N^3 - N^0    \\
    {\ensuremath{\mathup{P}_{384}} }&= N^{12} - N^4 - N^3 + N^1 - N^0
\end{aligned}\]

They are subset of the class of Generalized Mersennes defined by .

In future work, we plan to extend the study to consider the more general question of the distribution of group structure and curve exponent for the reduction of curves over fields for which the number of points is non-prime, and apply similar techniques with respect to the two curves proposed for IETF use, the nearly-Mersenne \({\ensuremath{\mathup{M}_{255}} }= 2^{255}-19\) and the Hamburg-Solinas trinomial \({\ensuremath{\mathup{H}_{448}} }= 2^{448}-2^{224}-1\). [1]

(We probably won’t extend this work to the Mersenne \(\textup{M}_{521}\), as that particular calculation is pestiferous.)

Numerical methods
=================

Finding prime-order curves
--------------------------

A slightly modified version of PARI/GP was used to calculate the traces of prime-order curves, based on code of . (The particular code used for this version of this paper may be found at .) Point-counting was aborted early if \(\#{\ensuremath{\BbbE_j} }\) was found to have a small prime factor.

Range
-----

We calculate <span>\(T_f(j)\) </span>for each <span>\(\BbbE_j\) </span>for \(0 < j < 2^{20}, j \neq 1728\), then test \(\#{\ensuremath{\BbbE_j} }\) and \(\#{\ensuremath{\BbbE^t_j(\BbbZ_q))} }\) for (pseudo-)primality.

(For this to be a reasonable procedure, it requires the assumption that \(j\)-invariant is not correlated with the probability of the curve being an elliptic twin, even on a local scale of \(2^{20}\).)

Results
-------

|                                    |             |              |                        |
|:-----------------------------------|:------------|:-------------|:-----------------------|
|                                    | \(N_{\pi}\) | \(N_{\pi'}\) | \(N_{\pi'} / N_{\pi}\) |
| <span>\(\mathup{P}_{224}\) </span> | 2790        | 31           | 1.1e-2                 |
| <span>\(\mathup{P}_{256}\) </span> | 1956        | 15           | 0.8e-2                 |
| <span>\(\mathup{P}_{384}\) </span> | 1131        | 20           | 1.8e-2                 |

Future work
===========

Because the above method results in fairly low precision in estimating \(N_{\pi'} / N_{\pi}\) because of the small number of doubly-prime curves, we plan to use two slightly different methods, essentially similar to those of .

*Procedure 1.* We generate \(N\) random \(j\)-invariants, \((j_{0,0}, \ldots, j_{N,0})\), and increment each by 1 until we find a doubly prime curve.

*Procedure 2.* We generate random \(j\)-invariants repeatedly until we collect N primes.

The procedure we will use to generate the random \(j\)-invariants is, for both procedures,

    for i in range(N):
      ok = False
      while not ok:
        input = shake256("Elliptic Twins over GF(0x%x),
                         procedure %u: i=%u, try=%u".format(procedure, P, j, try))
        maybep = l2b(shake256.squeeze(bitlen / 8))
        if maybep < P:
          ok = True
      js[i] = maybep

and similarly for procedure 2.

Concluding, mostly irrelevant aside
===================================

The quantity \(1 / {\ensuremath{\mathup{p}} }(p) = N_{\pi}({\ensuremath{\mathup{p}} }) / N_{\pi'}({\ensuremath{\mathup{p}} })\) is an estimator for the number of trials required, when choosing a prime curve uniformly at random in \(\BbbF_q\) for that curve to be an elliptic twin.

The probability, however, that no elliptic curves in a set of \(N\) are elliptic twins is, of course,

\[1 - \lparen \prod_{0 \leq i < n} 1 - {\ensuremath{\mathup{p}} }_q \rparen\]

With respect to the curves generated by the NSA for SECP, and subsequently standardized by NIST, this calculation gives a probability of very approximately \(< 5\%\) of any of the curves over \({\ensuremath{\mathup{P}_{224}} }, {\ensuremath{\mathup{P}_{256}} }, {\ensuremath{\mathup{P}_{384}} }\) being elliptic twins.

A Bayesian might thus conclude that it is more likely than not that the NSA’s curves were not generated by a process that samples from a uniform distribution on prime-order curves over the chosen prime fields.

An appropriate prior might include both

-   Only two of those curves are included in Suite B.

-   A previous instance in which the NSA did not disclose specific safety criteria for cryptographic primitives (DES).

This suggests that, perhaps, the NSA’s choice of seeds for the curves standardized by NIST were subject to additional safety criteria not yet publicly disclosed.

Acknowledgments
===============

The patch to PARI/GP used is derived from a patch by Michael Hamburg.

All of the non-trivial mathematics is entirely derived from prior work by Robert Ransom. The only novelty is in the application to this particular question.

Appendix. Cofactors for SafeCurves
==================================

This table is adapted (read stolen directly) from .

<span>llR</span> **Curve** &\(h({\ensuremath{\BbbE_j} })\) & \(h({\ensuremath{\BbbE^t_j(\BbbZ_q))} })\)
`M221 `& \(\scriptstyle 2^3\) & \(\scriptstyle 2^2                                                                  \)
`E222 `& \(\scriptstyle 2^2\) & \(\scriptstyle \mathbf{2^2}                                                                  \)
`secp224r1 `& \(\scriptstyle 1  \) & \(\scriptstyle 3^2 \cdot 11 \cdot 47 \cdot 3015283 \cdot 40375823 \cdot 267983539294927                 \)
`Curve1174 `& \(\scriptstyle 2^2\) & \(\scriptstyle \mathbf{2^2}                                                                  \)
`Curve25519 `& \(\scriptstyle 2^3\) & \(\scriptstyle 2^2                                                                  \)
`BN(2,254) `& \(\scriptstyle 1  \) & \(\scriptstyle 3^3 \cdot 3583 \cdot 298908837206431 \cdot 11711184643015782903697616449         \)
`brainpoolP256 `& \(\scriptstyle 1  \) & \(\scriptstyle 5^2 \cdot 175939 \cdot 492167257 \cdot 8062915307 \cdot 2590895598527 \cdot 4233394996199\)
`FRP256v1 `& \(\scriptstyle 1  \) & \(\scriptstyle 7 \cdot 439 \cdot 11760675247 \cdot 3617872258517821                             \)
`secp256r1 `& \(\scriptstyle 1  \) & \(\scriptstyle 3 \cdot 5 \cdot 13 \cdot 179                                                     \)
`secp256k1 `& \(\scriptstyle 1  \) & \(\scriptstyle 3^2 \cdot 13^2 \cdot 3319 \cdot 22639                                            \)
`E382 `& \(\scriptstyle 2^2\) & \(\scriptstyle \mathbf{2^2}                                                                  \)
`M383 `& \(\scriptstyle 2^3\) & \(\scriptstyle 2^2                                                                  \)
`Curve383187 `& \(\scriptstyle 2^3\) & \(\scriptstyle 2^2                                                                  \)
`brainpoolP384 `& \(\scriptstyle 1  \) & \(\scriptstyle 7 \cdot 11^2 \cdot 241 \cdot 5557 \cdot 125972502705620325124785968921221517         \)
`secp384r1 `& \(\scriptstyle 1  \) & \(\scriptstyle \mathbf{1}                                                                    \)
`Curve41417 `& \(\scriptstyle 2^3\) & \(\scriptstyle \mathbf{2^3}                                                                  \)
`Ed448 `& \(\scriptstyle 2^2\) & \(\scriptstyle \mathbf{2^2}                                                                  \)
`M511 `& \(\scriptstyle 2^3\) & \(\scriptstyle 2^2                                                                  \)
`E521 `& \(\scriptstyle 2^2\) & \(\scriptstyle \mathbf{2^2}\)

[1] The Hamburg primes are “Karatsuba-friendly” , who was the first to realize that these are extremely efficient for elliptic curve cryptography.
