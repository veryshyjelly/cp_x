# Created by Ayush Biswas at 2026/07/18 20:57
# https://atcoder.jp/contests/adt_medium_20250909_3/tasks/abc413_b
import ../lib/cpio

# @code begin

import sets

var r = newReader()

let
  n = r[int]
  strs = r[seq[string], n]

var corpus = initHashSet[string]()

for i in 0 ..< n:
  for j in 0 ..< n:
    if i == j:
      continue
    let s = strs[i] & strs[j]
    corpus.incl(s)

echo corpus.len

# @code end
