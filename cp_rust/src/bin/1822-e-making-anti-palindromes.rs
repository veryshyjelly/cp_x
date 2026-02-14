// Created by Ayush Biswas at 2025/12/10 10:35
// https://codeforces.com/problemset/problem/1822/E
use cp_lib::*;

use cpio::*;
// @code begin
use std::collections::HashMap;
use std::ops::AddAssign;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol_n! {
    fn solution(
        n: usize,
        s: [char]
    ) -> CPResult<usize, isize> {
        if n % 2 != 0 {
            return Failure(-1)
        }

        let mut mx = HashMap::new();
        let mut cnt = HashMap::new();
        let mut k = 0;

        for &c in &s {
            cnt.entry(c).or_insert(0).add_assign(1usize);
        }

        let c = cnt.into_values().max().unwrap_or(0);
        if c > n/2 {
            return Failure(-1);
        }

        for i in 0..n/2 {
            let j = n - i - 1;
            if s[i] == s[j] {
                k += 1;
                mx.entry(s[i]).or_insert(0).add_assign(1usize);
            }
        }

        let m = mx.into_values().max().unwrap_or(0);
        let res = ((k + 1) / 2).max(m);

        Success(res)
    }
}

// @code end
