# Created by Ayush Biswas at 2026/07/18 18:28
# https://atcoder.jp/contests/adt_easy_20260618_1/tasks/abc426_b
import ../lib/cpio
import ../lib/itertools

# @code begin

import sugar

var r = newReader()

let s = r[string].groupBy(k => k)

for k, v in s:
  if v.len == 1:
    echo k
    break

# @code end
