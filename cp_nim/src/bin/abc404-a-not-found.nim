# Created by Ayush Biswas at 2026/07/18 17:50
# https://atcoder.jp/contests/adt_easy_20260625_1/tasks/abc404_a
import ../lib/cpio

# @code begin

import sequtils

var r = newReader()

let s = r[string]

for c in 'a'..'z':
  if not s.contains(c):
    echo c
    break

# @code end
