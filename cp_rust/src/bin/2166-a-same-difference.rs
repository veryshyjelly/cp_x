// Created by Ayush Biswas at 2025/11/16 20:05
// https://codeforces.com/contest/2166/problem/A
use cp_lib::*;

// @code begin
use cpio::*;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol_n! {
    fn solution(
        n: usize,
        s: [char]
    ) -> usize {
        let need = s[n - 1];
        s.iter().filter(|&&c| c != need).count()
    }
}

// @code end
