// Created by Ayush Biswas at 2025/09/26 19:45
// https://codeforces.com/problemset/problem/2151/C
use cp_lib::*;

// @code begin
use cpio::*;

sol_n! {
    fn solution(
        n: usize,
        a: [usize]
    ) -> usize {
        let b = a.iter().min().unwrap();
        let c = a.iter().max().unwrap();
        (c - b) * (n - 1)
    }
}
// @code end
