# Created by Ayush Biswas at 2026/07/18 18:02
# https://atcoder.jp/contests/adt_easy_20260625_1/tasks/abc287_b
import ../lib/cpio

# @code begin

import sets

var r = newReader()

let
  (n, m) = r[int, int]
  s = r[seq[string], n]
  t = r[seq[string], m].toHashSet

var res: int
for w in s:
  if t.contains(w[^3 ..^ 1]):
    inc res
echo res

# @code end
