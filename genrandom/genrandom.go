package main

import (
	"crypto/elliptic"
	"fmt"
	"math/big"
	"os"

	"golang.org/x/crypto/sha3"
)

type curve struct {
	N      int
	params *elliptic.CurveParams
	bits   int
}

var (
	curves = []curve{
		curve{1000, elliptic.P224().Params(), 28},
		curve{1000, elliptic.P256().Params(), 32},
		curve{1000, elliptic.P384().Params(), 48},
	}
)

const (
	sqrtNd = 12
)

func main() {
	for _, c := range curves {
		f, err := os.Create(c.params.Name)
		if err != nil {
			fmt.Fprintf(os.Stderr, "error creating file %s: %s", c.params.Name, err)
			os.Exit(-1)
		}
		h := sha3.NewShake256()
		h.Write([]byte(c.params.Name))
		h.Write([]byte(": doubly prime"))
		buf := make([]byte, c.bits)
		v := new(big.Int)
		fmt.Fprintf(f, "[")
		for i := 0; i < 1000; i++ {
			if i != 0 {
				fmt.Fprintf(f, ",")
			}
			for trial := 0; ; trial++ {
				h.Read(buf)
				v.SetBytes(buf)
				if v.Cmp(c.params.P) == -1 {
					break
				}
			}
			fmt.Fprintf(f, "%d", v)
		}
		fmt.Fprintf(f, "]\n")
		f.Close()
	}
}
