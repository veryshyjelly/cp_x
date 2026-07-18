// Created by Ayush Biswas at 2026/07/03 19:48
// https://atcoder.jp/contests/abc042/tasks/arc058_a
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
