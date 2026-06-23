// Created by Ayush Biswas at 2026/05/06 19:37
// https://open.kattis.com/problems/buildinghighways
use cp_lib::*;

// @code begin
use cpio::*;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol! {
    fn solution(
        n: usize,
        a: [usize]
    ) -> usize {
        let b = a.iter().min().unwrap();
        a.iter().sum::<usize>() + (n - 2) * b
    }
}

// @code end
