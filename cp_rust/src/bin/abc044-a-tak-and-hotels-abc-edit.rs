// Created by Ayush Biswas at 2026/01/24 22:16
// https://atcoder.jp/contests/abc044/tasks/abc044_a
use cp_lib::*;

// @code begin
use cpio::*;

sol! {
    fn solution(
        n: usize,
        k: usize,
        x: usize,
        y: usize
    ) -> usize {
        if n >= k {
            (n - k) * y + k * x
        } else {
            n * x
        }
    }
}
// @code end
