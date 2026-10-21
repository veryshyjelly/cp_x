// Created by Ayush Biswas at 2026/07/12 20:05
// https://codeforces.com/contest/2246/problem/A
use cp_lib::*;

// @code begin
use cpio::*;

sol_n! {
    fn solution(
        n: usize,
    ) -> Words<usize> {
        (1..=n).rev().collect()
    }
}
// @code end
