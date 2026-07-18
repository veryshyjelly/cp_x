// Created by Ayush Biswas at 2026/07/12 20:20
// https://codeforces.com/contest/2246/problem/C
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;
use math::pow_mod;
use std::collections::HashMap;

const MOD: usize = 10usize.pow(9) + 7;

sol_n! {
    fn solution(
        n: usize,
        a: [i64]
    ) -> usize {
        let counts: HashMap<i64, usize> = a
            .into_iter()
            .group_by(|&x| x)
            .map(|g| (g[0], g.len()))
            .collect();

        let mut p = 1;
        for (_, c) in counts.iter() {
            p = (p * pow_mod(2, *c as i64 - 1, MOD as u32) as usize) % MOD;
        }

        let k = counts.keys().count_where(|&&v|
            v >= 1 && counts.contains_key(&(v + 1))
        );

        (if counts.contains_key(&-1) {
            p * (k + 1)
        } else {
            p
        }) % MOD
    }
}
// @code end
