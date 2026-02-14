// Created by Ayush Biswas at 2025/12/03 17:57
// https://codeforces.com/problemset/problem/1917/C

#![allow(unused_parens)]

use cp_lib::*;

// @code begin
use cpio::*;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol_n! {
    fn solution(
        [n, k, d]: [usize; 3],
        (mut a): [usize],
        v: [usize]
    ) -> usize {
        if a.iter().sum::<usize>() == 0 {
            return d/2;
        }

        let mut max_score = score(&a, n) + (d - 1) / 2;
        for i in 0..(d - 1).min(2*n) {
            let b = v[i % k];
            for i in 0..b {
                a[i] += 1;
            }
            let harvest = score(&a, n);
            let remaining_days = d - i - 2;
            max_score = max_score.max(harvest + remaining_days / 2);
        }
        max_score
    }
}

fn score(a: &Vec<usize>, n: usize) -> usize {
    let mut res = 0;
    for i in 0..n {
        if a[i] == i + 1 {
            res += 1;
        }
    }
    res
}

// @code end
