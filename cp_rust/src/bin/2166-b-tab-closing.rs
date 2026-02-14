// Created by Ayush Biswas at 2025/11/16 20:13
// https://codeforces.com/contest/2166/problem/B
use cp_lib::*;

// @code begin
use cpio::*;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol_n! {
    fn solution(
        [a, b, n]: [usize; 3]
    ) -> usize {
        if a / n < b && a != b {
            2
        } else {
            1
        }
    }
}

// @code end
