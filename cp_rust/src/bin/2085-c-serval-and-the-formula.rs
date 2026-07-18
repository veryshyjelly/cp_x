// Created by Ayush Biswas at 2025/11/18 15:07
// https://codeforces.com/problemset/problem/2085/C
use cp_lib::*;

// @code begin
use cpio::*;
use std::mem::swap;

sol_n! {
    fn solution(
        [mut x, mut y]: [usize; 2]
    ) -> CPResult<usize, isize> {
        if x == y {
            return Failure(-1)
        }

        if x < y {
            swap(&mut x, &mut y);
        }

        let mut k = 1usize << x.ilog2();
        if k < x {
            k <<= 1;
        }

        Success(k - x)
    }
}
// @code end
