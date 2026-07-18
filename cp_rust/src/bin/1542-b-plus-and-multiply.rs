// Created by Ayush Biswas at 2026/05/23 13:42
// https://codeforces.com/problemset/problem/1542/B
use cp_lib::*;

// @code begin
use cpio::*;

sol_n! {
    fn solution(
        [n, a, b]: [usize; 3]
    ) -> Bool {
        if a == 1 {
            return ((n - 1)%b == 0).into()
        }
        let mut c = 1;
        while c <= n {
            if c % b == n%b {
                return true.into()
            }
            c *= a;
        }
        false.into()
    }
}
// @code end
