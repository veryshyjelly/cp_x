# Created by Ayush Biswas at 2026/07/19 08:42
# https://atcoder.jp/contests/adt_hard_20250619_2/tasks/abc398_c
import ../lib/cpio

# @code begin

import sets, sequtils

var r = newReader()

let
  n = r[int]
  a = r[seq[int]]

var seen = initHashSet[int]()
var possibleRes = initHashSet[int]()

for i, ai in a.pairs():
  if ai notin seen:
    possibleRes.incl(ai)
    seen.incl(ai)
  else:
    possibleRes.excl(ai)

if possibleRes.len != 0:
  let m = possibleRes.toSeq.max()
  for i in 0 .. a.high:
    if a[i] == m:
      echo i + 1
else:
  echo -1

# @code end
