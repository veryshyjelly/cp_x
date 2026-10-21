// Created by Ayush Biswas at 2026/07/07 20:36
// https://atcoder.jp/contests/adt_easy_20260617_1/tasks/abc434_b
use cp_lib::*;

// @code begin
use cpio::*;

sol! {
    fn solution(
        [n, m]: [usize; 2],
        abs: [[u32; 2]; n]
    ) -> Lines<f64> {
        let mut sums = vec![0; m + 1];
        let mut counts = vec![0; m + 1];
        for [a, b] in abs {
            counts[a as usize] += 1;
            sums[a as usize] += b;
        }
        let mut res = vec![];
        for i in 1..=m {
            res.push(f64::from(sums[i])/f64::from(counts[i]));
        }
        res.into()
    }
}
// @code end
