// Created by Ayush Biswas at 2025/12/03 22:42
// https://codeforces.com/problemset/problem/2065/E
use cp_lib::*;

// @code begin
use cpio::*;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol_n! {
    fn solution(
        [mut n, mut m, k]: [usize; 3]
    ) -> String {
        let mut s = String::new();
        let (mut a, mut b) = ('0', '1');
        if n < m {
            (n, m) = (m, n);
            (a, b) = (b, a);
        }
        if k > n || k < n - m {
            return "-1".into()
        }
        s.extend(vec![a; k]);
        n -= k;
        while n > 0 && m > 0 {
            n -= 1;
            m -= 1;
            s.extend(vec![b, a]);
        }
        s.extend(vec![b; m]);
        s
    }
}

// @code end
