// Created by Ayush Biswas at 2025/11/16 20:18
// https://codeforces.com/contest/2166/problem/C
use cp_lib::*;

// @code begin
use cpio::*;
use std::cmp::max;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol_n! {
    fn solution(
        n: usize,
        a: [usize]
    ) -> usize {
        if n == 2 {
            return *a.iter().max().unwrap()
        }
        let mut keep = Vec::with_capacity(n);
        for i in 1..n {
            keep.push(max(a[i - 1], a[i]));
        }
        keep.push(max(a[0], a[n - 1]));
        keep.sort();
        keep.into_iter().take(n - 1).sum()
    }
}

// @code end
