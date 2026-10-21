// Created by Ayush Biswas at 2026/07/05 20:03
// https://codeforces.com/gym/701868/problem/A
use cp_lib::*;

// @code begin
use cpio::*;

sol_n! {
    fn solution(
        n: usize,
    ) -> Words<usize> {
        vec![n - 3, 1, 1, 1].into()
    }
}
// @code end
