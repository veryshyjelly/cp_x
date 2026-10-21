# Created by Ayush Biswas at 2026/07/18 17:43
# https://atcoder.jp/contests/adt_easy_20260626_1/tasks/abc386_a
import ../lib/cpio
import ../lib/itertools

# @code begin

import sugar, algorithm

var r = newReader()

let cards = r[seq[int]]

var lens = collect:
  for k, v in cards.groupBy(k => k):
    v.len

lens.sort

if lens == @[1, 3] or lens == @[2, 2]:
  echo "Yes"
else:
  echo "No"

# @code end
