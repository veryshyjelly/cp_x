// Created by Ayush Biswas at 2026/05/12 21:55
// https://open.kattis.com/problems/kingsdecree
use cp_lib::*;

// @code begin
use cpio::*;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol_n! {
    fn solution(
        n: usize,
        balances: [usize],
        (mut limits): [usize]
    ) -> usize {
        let mut extras = (0..n)
            .map(|i| balances[i] - limits[i])
            .sum::<usize>();
        limits.sort();
        let mut x = limits[0];
        let mut k = 1;
        for &y in &limits[1..] {
            let x2 = x + (extras / k);
            if x2 <= y {
                return x2;
            } else {
                extras -= (y - x) * k;
                x = y;
                k += 1;
            }
        }
        x + (extras / k)
    }
}

// @code end
