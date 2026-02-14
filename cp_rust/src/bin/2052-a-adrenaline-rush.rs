// Created by Ayush Biswas at 2025/12/10 17:05
// https://codeforces.com/problemset/problem/2052/A
use cp_lib::*;
// @code begin
use cpio::*;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol! {
    fn solution(
        n: usize,
        a: [usize]
    ) -> Lines<Words<usize>> {
        let mut result = vec![vec![0]];
        let mut processed = vec![false; n + 1];
        for ai in a.into_iter().rev() {
            processed[ai] = true;
            for i in (1..ai).rev() {
                if !processed[i] {
                    result.push(vec![ai, i]);
                }
            }
            for i in 1..=n {
                if !processed[i] {
                    result.push(vec![i, ai]);
                }
            }
        }

        result[0][0] = result.len() - 1;
        result.into_iter().map(|x| x.into()).collect()
    }
}

// @code end
