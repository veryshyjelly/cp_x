# Created by Ayush Biswas at 2025/10/15 12:26
# https://codeforces.com/problemset/problem/1904/C
from cpio.cpio import sol_n

# @code begin
from bisect import bisect_left, bisect_right


@sol_n("n k; ints")
def solution(n: int, k: int, a: list[int]) -> int:
    if k >= 3:
        return 0

    a = sorted(a)

    if k == 1:
        res = float("inf")
        for i in range(n - 1):
            res = min(res, abs(a[i + 1] - a[i]))
        return res

    res = float("inf")
    for i in range(n):
        for j in range(i + 1, n):
            v = abs(a[i] - a[j])
            res = min(res, v)
            idx = bisect_left(a, v)
            if idx < len(a):
                res = min(res, abs(a[idx] - v))
            res = min(res, abs(v - a[idx - 1]))
            idx = bisect_right(a, v)
            if idx < len(a):
                res = min(res, abs(a[idx] - v))
            res = min(res, abs(v - a[idx - 1]))

    return res


solution()

# @code end
