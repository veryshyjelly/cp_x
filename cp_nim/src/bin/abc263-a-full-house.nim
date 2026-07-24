# Created by Ayush Biswas at 2026/07/19 12:17
# https://atcoder.jp/contests/adt_easy_20240201_1/tasks/abc263_a
import ../lib/cpio
import ../lib/itertools

# @code begin

import sugar, tables, sequtils, algorithm

var r = newReader()

if r[seq[int]].groupBy(k => k).values.toSeq.mapIt(it.len).sorted == @[2, 3]:
  echo "Yes"
else:
  echo "No"

# @code end

