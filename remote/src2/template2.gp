\g 0;
\gm 0;

install(Fp_ellcard_SEA,"GGGL");
allocatemem(8000000000);
default(nbthreads,36);

seabyj(j0, p, name, twist) = {
 my(filename=Str(name, "/", j0));

 print("j0 = \n", j0);
 
 my(pq = 0);
 my(pt = 0);
 my(px = 0);

 my(j = j0 - 1);

 my(notpx = []);

 while(!px,
    j = j + 1;
    /* Fp_ellcard_SEA takes a4 and a6. */
    my(a4 = (36 / (j - 1728)) % p);
    my(a6 = (-1 / (j - 1728)) % p);
   
    /* Count the points. */
    my(tff = Fp_ellcard_SEA(a4, a6, p, if(twist, -1, 1)));

    print("deltaj = ", j - j0, "\n",
          "a4 = ", a4, ", a6 = ", a6, "\n",
          "tff = ", tff, "\n");

    /* If tff[1] isn't 0, tff[2] is some small factor of the
     * curve's order.
     */
    write(Str(filename, ".checkpoint"), j);
     
    if(tff == 0,
       notpx = concat(notpx, tff[2]);,
    /* If tff[1] is 0, tff[2] is the trace of Frobenius.
     */
    my(tf = tff[2]);
    my(q  = p + 1 - tf);
    my(qt = p + 1 + tf);
    pq = ispseudoprime(q);
    pt = ispseudoprime(qt);
    px = pq & (!twist || pt);
    
    if(px,
       write(filename,
             Strprintf("{j0: 0x%x, j: 0x%x,\n deltaj: 0x%x,\n tf: 0x%x,\n pE: %u,\n pT: %u,\n p2: %u,\n length: %u,\n notpx: %s}",
                       j0, j, j - j0, tf, pq, pt, pq && pt, length(notpx), notpx));
       return();
       );
    );
    );
};

sea384(jjj) = {
  seabyj(jjj%jjj, 2^384 - 2^128 - 2^96 + 2^32 - 1, "sol384d", 1);
};

sea384(jjj);
