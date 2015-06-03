
from itertools import product
sols = []
def sgn(n):
  return '-' if n < 0 else '+'
for z in [-1, 1]:
  for coeff in product([-1, 0, 1], repeat=11):
    coeff = list(coeff) + [1]
    if sum(abs(c) for c in coeff) > 4:
      continue
    v = sum(c * 2**(32*(i+1)) for i, c in enumerate(coeff)) + z
    if v < 0 or v > 2**384:
      continue
    if isprime(v):
      sols += [v]
      print('{:36} {} {}'.format(
        ' '.join('{} 2^{:<3}'.format(sgn(c), (i+1)*32)
            for i, c
            in reversed(list(enumerate(coeff))) if c != 0) + ' {} {}'.format(sgn(z), abs(z)),
            '0x{:097x}'.format(v), v%4))


