// Created by Ayush Biswas at 2026/01/20 20:33
// https://atcoder.jp/contests/abc043/tasks/abc043_a
use cp_lib::*;

// @code begin
use cpio::*;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol! {
    fn solution(
        n: usize,
    ) -> usize {
        ((n + 1) * n) / 2
    }
}

// @code end
