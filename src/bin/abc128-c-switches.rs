// Created by Ayush Biswas at 2026/07/04 11:56
// https://atcoder.jp/contests/abc128/tasks/abc128_c
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
