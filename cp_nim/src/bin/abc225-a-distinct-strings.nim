# Created by Ayush Biswas at 2026/07/19 17:12
# https://atcoder.jp/contests/adt_all_20240102_2/tasks/abc225_a
import ../lib/cpio

# @code begin

import algorithm

var r = newReader()

let s = r[Chars]

var t = seq[char](s).sorted

var res = 1
while t.nextPermutation:
  inc res

echo res

# @code end

