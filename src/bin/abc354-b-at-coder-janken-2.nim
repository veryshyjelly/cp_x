# Created by Ayush Biswas at 2026/07/19 11:00
# https://atcoder.jp/contests/adt_easy_20240724_2/tasks/abc354_b
import ../lib/cpio

# @code begin

import strutils, algorithm

var r = newReader()

let
  n = r[int]
  a = r[seq[seq[string]], n].sortedByIt(it[0])

var totalScore: int
for user in a:
  totalScore += user[1].parseInt

echo a[totalScore mod n][0]

# @code end
