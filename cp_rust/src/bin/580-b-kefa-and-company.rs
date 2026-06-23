// Created by Ayush Biswas at 2026/05/22 19:58
// https://codeforces.com/problemset/problem/580/B
use cp_lib::*;

// @code begin
use cpio::*;

sol! {
    fn solution(
        [n, d]: [usize; 2],
        (mut friends): [[usize; 2]; n]
    ) -> usize {
        friends.sort_unstable_by_key(|x| x[0]);
        let mut sum = friends[0][1];
        let mut max_sum = sum;
        let mut back_ptr = 0;
        for i in 1..n {
            while friends[back_ptr][0] + d <= friends[i][0] {
                sum -= friends[back_ptr][1];
                back_ptr += 1;
            }
            sum += friends[i][1];
            max_sum = max_sum.max(sum);
        }
        max_sum
    }
}

// @code end
