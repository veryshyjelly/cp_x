// Created by Ayush Biswas at 2026/05/16 01:15
// https://open.kattis.com/problems/goldmerchant
use cp_lib::*;

// @code begin
use cpio::*;
use dsu::*;
use itertools::Itertools;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol! {
    fn solution(
        [n, m]: [usize; 2],
        w: [usize],
        v: [usize],
        pairs: [[usize; 2]; m]
    ) -> usize {
        let mut dsu = Dsu::new(n);
        for [a, b] in pairs {
            dsu.merge(a - 1, b - 1);
        }
        let mut res = 0;
        for g in dsu.groups() {
            let w = g.iter().map(|&gi| w[gi]).sorted();
            let v = g.iter().map(|&gi| v[gi]).sorted();
            res += w.zip(v).map(|(wi, vi)| wi * vi).sum::<usize>();
        }
        res
    }
}

// @code end
