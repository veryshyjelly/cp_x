# Created by Ayush Biswas at 2026/07/19 16:02
# https://atcoder.jp/contests/adt_all_20240116_2/tasks/abc294_c
import ../lib/cpio

# @code begin

import sugar, sequtils, algorithm

var r = newReader()

let
  (n, m) = r[int, int]
  a = collect:
    for i, x in r[seq[int]].pairs:
      (x, i, 0)
  b = collect:
    for i, x in r[seq[int]].pairs:
      (x, i, 1)

var 
  c = newSeq[(int, int, int)]()
  apos = newSeq[int](n)
  bpos = newSeq[int](m)

c.add a
c.add b
c.sort()

for i in 0 ..< n+m:
  if c[i][2] == 0:
    apos[c[i][1]] = i + 1
  else:
    bpos[c[i][1]] = i + 1

echo Words(apos)
echo Words(bpos)

# @code end

