// Created by Ayush Biswas at 2026/05/23 13:42
// https://codeforces.com/problemset/problem/1542/B
use cp_lib::*;

// @code begin
use cpio::*;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol_n! {
    fn solution(
        [n, a, b]: [usize; 3]
    ) -> String {
        if a == 1 {
            return if (n - 1)%b == 0 {
                "Yes"
            } else {
                "No"
            }.into()
        }
        let mut c = 1;
        while c <= n {
            if c % b == n%b {
                return "Yes".into()
            }
            c *= a;
        }
        "No".into()
    }
}

// @code end
