# Created by Ayush Biswas at 2026/07/18 20:54
# https://atcoder.jp/contests/adt_easy_20251023_3/tasks/abc419_b
import ../lib/cpio

# @code begin

import heapqueue

var r = newReader()

let
  n = r[int]
  queries = r[seq[seq[int]], n]

var h = initHeapQueue[int]()

for query in queries:
  if query[0] == 1:
    h.push(query[1])
  else:
    echo h.pop()

# @code end
