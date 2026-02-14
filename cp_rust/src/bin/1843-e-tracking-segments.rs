// Created by Ayush Biswas at 2025/11/18 14:16
// https://codeforces.com/problemset/problem/1843/E
use cp_lib::*;

// @code begin
use cpio::*;
use binary_search::*;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol_n! {
    fn solution(
        [n, m]: [usize; 2],
        ranges: [[usize; 2]; m],
        q: usize,
        idxs: [usize]; q
    ) -> isize {
        let f = |x: usize| -> bool {
            let mut a = vec![0u32; n + 1];
            for i in 0..x {
                a[idxs[i]] = 1;
            }
            for i in 0..n {
                a[i + 1] += a[i]; 
            }
            for &[l, r] in &ranges {
                if a[r] - a[l - 1] > ((r - l + 1) / 2) as u32 {
                    return true 
                }
            }
            false 
        };
        let res = search_right(0, q, f);
        if f(res) {
            res as isize
        } else {
            -1
        }
    }
}

// @code end
