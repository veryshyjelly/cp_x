// Created by Ayush Biswas at 2026/05/11 16:45
// https://open.kattis.com/problems/fakearithmeticsequence
use cp_lib::*;

// @code begin
use cpio::*;

sol! {
    fn solution(
        n: usize,
        a: [isize]
    ) -> usize {
        let mut res = 0;
        for i in 0..n {
            for j in i+1..n {
                let mut b = 2;
                let (mut c, mut d) = (a[i], a[j]);
                let mut a = &a[j + 1..];
                while let Some(k) = a.iter().position(|&ai| ai == c + d) {
                    (c, d) = (d, a[k]);
                    a = &a[k + 1..];
                    b += 1;
                }
                res = res.max(b);
            }
        }
        res
    }
}
// @code end
