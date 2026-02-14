// Created by Ayush Biswas at 2025/11/17 20:05
// https://codeforces.com/problemset/problem/1857/F
use cp_lib::*;
// @code begin
use cpio::*;
use itertools::*;
use std::collections::HashMap;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol_n! {
    fn solution(
        _n: usize,
        a: [isize],
        q: usize,
        queries: [[isize; 2]; q]
    ) -> Words<usize> {
        let count: HashMap<isize, usize> = a
            .into_iter().sorted()
            .group_by(|x| *x)
            .map(|g| (g[0], g.len()))
            .collect();
        queries.into_iter().map(|[x, y]| {
            let d = x*x - 4*y;
            if d < 0 {
                return 0
            }
            let discr = d.isqrt();
            // eprintln!("d: {d}, discr: {discr}");
            if discr*discr != d || (x + discr) % 2 != 0 {
                return 0;
            }
            let ai = (x - discr) / 2;
            let aj = (x + discr) / 2;
            if ai == aj {
                let r = *count.get(&ai).unwrap_or(&0);
                return if r == 0 {
                    r
                } else {
                    r * (r - 1) / 2
                }
            }
            // eprintln!("ai: {ai}, aj: {aj}");
            let r = count.get(&ai).unwrap_or(&0) * count.get(&aj).unwrap_or(&0);
            r
        }).collect()
    }
}

// @code end
