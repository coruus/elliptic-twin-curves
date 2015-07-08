\g 1;
\gm 2;

install(ellsea,"GGL");
allocatemem(60000000000);
default(nbthreads,32);

seabyj(j0, np) = {
 my(p, n, c);
 n = np[1];
 p = np[2];
 c = "sol_";
 my(filename=Str("sol", n, "/", j0));
 my(ffilename=Str("fail_sol", n, "/", j0));

 my(E,tff,tf,q,qt,pq,pt,ff,r,a4,a6);

 /* It's pointless to count singular curves. */
 if(j0 == 1728 || j0 == 0, return());

 /* Fp_ellcard_SEA takes a4 and a6. */
 my(a4 = (36 / (j0 - 1728)) % p);
 my(a6 = (-1 / (j0 - 1728)) % p);

 /* Count the points. */
 my(tff = ellsea(ellinit([a4, a6]), p, 1));

 print("j0 = ", j0, "\n");
 print("a4 = ", a4, ", a6 = ", a6, "\n");
 print("tff = ", tff, "\n");

 /* If tff[1] isn't 0, tff[2] is some small factor of the
  * curve's order.
  *
  * If tff[1] is 0, tff[2] is the trace of Frobenius.
  */
 if(tff == 0,
    return());

 tf = tff;
 q  = p + 1 - tf;
 qt = p + 1 + tf;
 pq = ispseudoprime(q);
 pt = ispseudoprime(qt);
 /* If you want to waste time with primality proofs, replace
  * ispseudoprime with the commented out lines. */
 /* proof_pq = isprime(q);  /* isprime(q, 1) */
 /* proof_pt = isprime(qt); /* isprime(q, 1) */
 if(pq,
    write(filename,
          Strprintf("{j: %x,\n tf: %x,\n pE: %u,\n pT: %u,\n p2: %u}",
                    j0, tf, pq, pt, pq && pt)));
 return();
};

my(sea=seabyj); r = parfor(j=1, 2^20, sea(j, [224, 2^224 - 2^96 + 1]));
/* Sol224 */
/* */
/* Sol256 */
/* r = parfor(j=1, 2^20, sea(j, [256, 2^256 - 2^224 + 2^192 + 2^96 - 1]));
 */
/* Sol384 */
/*my(sea=seabyj); parfor(j=2^256, 2^256+2^20, sea(j, [384, 2^384 - 2^128 - 2^96 + 2^32 - 1])); */
/* */
/* Sol521 */
/* r = parfor(j=1, 2^20, sea(j, [521, 2^521 - 1]));
 */

/* Sol256 */
/* r = parfor(j=1, 2^20, sea(j, [256, 2^256 - 2^224 + 2^192 + 2^96 - 1])); */
