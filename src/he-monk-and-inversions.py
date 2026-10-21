# Created by Ayush Biswas at 2025/11/15 21:38
# https://www.hackerearth.com/practice/codemonk/
from cpio.cpio import sol_n

# @code begin
from bisect import bisect_right, insort
import sys


@sol_n("n; n*ints")
def solution(n: int, a: list[list[int]]) -> int:
    seen = []
    res = 0
    l = 0
    for i in range(n):
        for j in range(n):
            res += l - bisect_right(seen, a[i][j])
            print(res, file=sys.stderr)
            insort(seen, a[i][j])
            l += 1

    return res


solution()

# @code end
