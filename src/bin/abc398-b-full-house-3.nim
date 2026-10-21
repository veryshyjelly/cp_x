# Created by Ayush Biswas at 2026/07/19 09:32
# https://atcoder.jp/contests/adt_medium_20250605_3/tasks/abc398_b
import ../lib/cpio
import ../lib/itertools

# @code begin

import sugar, sequtils, tables, algorithm

var r = newReader()

let a = r[seq[int]].groupBy(k => k)

let sizes = a.values.toSeq.map(x => x.len).sorted

if sizes.len >= 2 and sizes[^1] >= 3 and sizes[^2] >= 2:
  echo "Yes"
else:
  echo "No"

# @code end
