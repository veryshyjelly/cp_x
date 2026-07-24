# Created by Ayush Biswas at 2026/07/19 15:15
# https://atcoder.jp/contests/adt_hard_20240118_3/tasks/abc322_c
import ../lib/cpio

# @code begin

import deques

var r = newReader()

var
  (n, m) = r[int, int]
  a = r[seq[int]].toDeque

for i in 1 .. n:
  if a.peekFirst < i:
    discard a.popFirst()
  echo a.peekFirst - i

# @code end

