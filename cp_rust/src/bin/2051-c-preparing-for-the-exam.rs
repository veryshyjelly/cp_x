// Created by Ayush Biswas at 2025/08/23 19:26
// https://codeforces.com/problemset/problem/2051/C
use cp_lib::*;

// @code begin
use cpio::*;

sol_n! {
    fn solution(
        [n, m, k]: [usize; 3],
        a: [usize],
        q: [usize]
    ) -> ListOf<'\0', usize> {
        if k == n {
            return vec![1; m].into()
        } else if k < n - 1 {
            return vec![0; m].into()
        }
        let missing = q.into_iter().zip(1..).fold(0, |acc, (qi, i)| acc ^ qi ^ i) ^ n;
        a.into_iter().map(|ai| if ai == missing {1} else {0}).collect()
    }
}
// @code end
