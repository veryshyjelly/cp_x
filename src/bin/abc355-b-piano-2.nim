# Created by Ayush Biswas at 2026/07/19 11:24
# https://atcoder.jp/contests/adt_easy_20240702_1/tasks/abc355_b
import ../lib/cpio

# @code begin

import sugar, sequtils, algorithm

var r = newReader()

var
  (n, m) = r[int, int]
  a = r[seq[int]].map(x => (x, 0))
  b = r[seq[int]].map(x => (x, 1))

a.add b
a.sort

if (1 .. a.high).anyIt(a[it - 1][1] == 0 and a[it][1] == 0):
  echo "Yes"
else:
  echo "No"

# @code end
