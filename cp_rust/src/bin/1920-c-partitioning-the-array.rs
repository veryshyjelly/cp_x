// Created by Ayush Biswas at 2025/11/18 15:54
// https://codeforces.com/problemset/problem/1920/C
use cp_lib::*;

// @code begin
use cpio::*;
use math::gcd;

// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);
// const N: u32 = 2 * 100000;

sol_n! {
    fn solution(
        n: usize,
        a: [isize]
    ) -> usize {
        let mut res =  0;
        for k in 1..=n {
            if n%k == 0 {
                let mut g = 0;
                for i in 0..n-k {
                    g = gcd(g, (a[i + k] - a[i]).abs())
                }
                if g != 1 {
                    res += 1;
                }
            }
        }
        res
    }
}

// @code end
