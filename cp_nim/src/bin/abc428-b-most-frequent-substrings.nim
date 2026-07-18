# Created by Ayush Biswas at 2026/07/18 18:17
# https://atcoder.jp/contests/adt_all_20260623_2/tasks/abc428_b
import ../lib/cpio

# @code begin

import strutils, tables, sugar, sequtils, algorithm

var r = newReader()

let
  (n, k) = r[int, int]
  s = r[string]

var freqs = initCountTable[string]()
for i in 0 .. n - k:
  freqs.inc(s[i..<i+k])

let maxFreq = freqs.values.toSeq.max()
echo maxFreq
let res = collect:
  for k, v in freqs:
    if v == maxFreq: k
echo res.sorted.join(" ")

# @code end
