// Created by Ayush Biswas at 2026/07/06 20:07
// https://codeforces.com/contest/2242/problem/A
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;

sol_n! {
    fn solution(
        k: usize,
        c: [usize]
    ) -> Bool {
        if c.iter().any(|&x| x >= 3) {
           return true.into()
        }

        let count = c.into_iter().count_where(|&x| x >= 2);
        (count >= 2).into()
    }
}
// @code end
