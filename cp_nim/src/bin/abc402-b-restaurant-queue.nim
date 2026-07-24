# Created by Ayush Biswas at 2026/07/19 08:29
# https://atcoder.jp/contests/adt_easy_20250903_1/tasks/abc402_b
import ../lib/cpio

# @code begin

import deques

var r = newReader()

let
  n = r[int]
  queries = r[seq[seq[int]], n]

var queue = initDeque[int]()
for q in queries:
  if q[0] == 1:
    queue.addLast q[1]
  else:
    echo queue.popFirst()

# @code end
