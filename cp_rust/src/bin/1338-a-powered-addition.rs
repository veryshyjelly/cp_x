// Created by Ayush Biswas at 2026/05/23 08:51
// https://codeforces.com/problemset/problem/1338/A
use cp_lib::*;

// @code begin
use cpio::*;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol_n! {
    fn solution(
        n: usize,
        a: [isize]
    ) -> usize {
        let mut maxi = a[0];
        let mut res = 0;
        for ai in a {
            if ai > maxi {
                maxi = ai;
            } else {
                res = res.max(bit_count(maxi - ai));
            }
        }
        res
    }
}

fn bit_count(mut x: isize) -> usize {
    let mut res = 0;
    while x != 0 {
        res += 1;
        x /= 2;
    }
    res
}

// @code end
