# Created by Ayush Biswas at 2026/07/19 12:05
# https://atcoder.jp/contests/adt_easy_20240313_2/tasks/abc337_b
import ../lib/cpio

# @code begin

import sequtils, algorithm

var r = newReader()

let s = r[string]

if s.isSorted:
  echo "Yes"
else:
  echo "No"

# @code end

