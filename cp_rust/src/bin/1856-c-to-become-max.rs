// Created by Ayush Biswas at 2025/11/17 22:50
// https://codeforces.com/problemset/problem/1856/C
use cp_lib::*;
// @code begin
use binary_search::*;
use cpio::*;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol_n! {
    fn solution(
        [n, k]: [usize; 2],
        a: [usize]
    ) -> usize {
        fn f(a: &Vec<usize>, n: usize, i: usize, x: usize) -> usize {
            if a[i] >= x {
                return 0
            }
            if i == n - 1 {
                return usize::MAX/n;
            }
            x - a[i] + f(a, n, i + 1, x - 1)
        }
        let g = |x: usize| -> bool {
            for i in 0..n {
                if f(&a, n, i, x) <= k {
                    return true
                }
            }
            false
        };
        let lo = *a.iter().max().unwrap();
        search_left(lo, lo + n + 1, g) - 1
    }
}

// @code end
