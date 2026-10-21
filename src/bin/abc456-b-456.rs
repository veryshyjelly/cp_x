// Created by Ayush Biswas at 2026/07/07 20:49
// https://atcoder.jp/contests/adt_all_20260615_2/tasks/abc456_b
use cp_lib::*;

// @code begin
use cpio::*;

sol! {
    fn solution(
        a: [usize],
        b: [usize],
        c: [usize]
    ) -> f64 {
        let mut cases = 0;
        for i in 0..6 {
            for j in 0..6 {
                for k in 0..6 {
                    let mut s = [a[i], b[j], c[k]];
                    s.sort();
                    if [4, 5, 6] == s {
                        cases += 1;
                    }
                }
            }
        }
        f64::from(cases) / f64::from(6*6*6)
    }
}
// @code end
