// Created by Ayush Biswas at 2026/07/06 21:08
// https://codeforces.com/contest/2242/problem/D
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;
use std::cmp::max;

sol_n! {
    fn solution(
        a: [char],
        b: [char]
    ) -> isize {
        let a: Vec<u32> = a.into_iter().map(|ai| ai.to_digit(10).unwrap()).collect_vec();
        let b: Vec<u32> = b.into_iter().map(|bi| bi.to_digit(10).unwrap()).collect_vec();

        let (n, m) = (a.len(), b.len());

        let mut a_prefix = vec![0; a.len() + 1];
        for (i, &ai) in a.iter().enumerate() {
            a_prefix[i + 1] = (a_prefix[i] + ai) % 10;
        }
        let mut b_prefix = vec![0; b.len() + 1];
        for (i, &bi) in b.iter().enumerate() {
            b_prefix[i + 1] = (b_prefix[i] + bi) % 10;
        }

        if a_prefix[n] != b_prefix[m] {
            return -1;
        }

        let mut res = vec![vec![0; m + 1]; n + 1];

        for i in 1..=n {
            for j in 1..=m {
                if a_prefix[i] == b_prefix[j] {
                    res[i][j] = max(
                        1 + res[i - 1][j - 1],
                        max(
                            res[i - 1][j],
                            res[i][j - 1]
                        )
                    );
                } else {
                    res[i][j] = max(
                            res[i - 1][j],
                            res[i][j - 1]
                    );
                }
            }
        }

        res[n][m] as isize
    }
}
// @code end
