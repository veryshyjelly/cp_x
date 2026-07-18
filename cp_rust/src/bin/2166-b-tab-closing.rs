// Created by Ayush Biswas at 2025/11/16 20:13
// https://codeforces.com/contest/2166/problem/B
use cp_lib::*;

// @code begin
use cpio::*;

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
