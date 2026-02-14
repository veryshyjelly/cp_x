// Created by Ayush Biswas at 2025/12/10 15:15
// https://codeforces.com/problemset/problem/1849/C
use cp_lib::*;

// @code begin
use std::collections::HashSet;
use cpio::*;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol_n! {
    fn solution(
        [n, m]: [usize; 2],
        a: [01],
        ranges: [[usize; 2]; m]
    ) -> usize {
        let mut previous_zero = vec![0usize; n + 2];
        for i in 1..=n {
            if a[i - 1] == 0 {
                previous_zero[i] = i;
            } else {
                previous_zero[i] = previous_zero[i - 1];
            }
        }
        let mut after_one = vec![n + 1; n + 2];
        for i in (1..=n).rev() {
            if a[i - 1] == 1 {
                after_one[i] = i;
            } else {
                after_one[i] = after_one[i + 1];
            }
        }
        let mut uniq_ranges = HashSet::new();
        for [l, r] in ranges {
            let [l, r] = [after_one[l], previous_zero[r]];
            if l >= r {
                uniq_ranges.insert((0, n + 1));
            } else {
                uniq_ranges.insert((l, r));
            }
        }
        uniq_ranges.len()
    }
}

// @code end
