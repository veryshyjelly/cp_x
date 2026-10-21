# Created by Ayush Biswas at 2026/07/18 19:15
# https://atcoder.jp/contests/adt_easy_20260212_1/tasks/abc439_b
import ../lib/cpio

# @code begin

import sets, math

var r = newReader()

let n = r[int]

var seen = initHashSet[int]()
var m = n

func process(i: int): int =
  var i = i
  while i != 0:
    result += (i mod 10) ^ 2
    i = i div 10

while not seen.contains(m):
  seen.incl(m)
  m = process(m)

if m == 1:
  echo "Yes"
else:
  echo "No"

# @code end
