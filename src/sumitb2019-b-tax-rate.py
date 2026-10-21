# Created by Ayush Biswas at 2026/07/03 18:13 
# https://atcoder.jp/contests/sumitrust2019/tasks/sumitb2019_b
from cpio.cpio import sol_n

# @code begin

from math import ceil, floor


@sol("n; ints")
def solution(n: int, a: list[int]) -> str | int:
    m = ceil((n * 100) / 108)
    if floor(m * 1.08) == n or ceil(m * 1.08) == n:
        return m
    return ":("


solution()

# @code end

