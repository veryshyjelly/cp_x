// Created by Ayush Biswas at 2026/07/05 20:23
// https://codeforces.com/gym/701868/problem/B
use cp_lib::*;

// @code begin
use cpio::*;

sol! {
    fn solution(
        [n, k]: [usize; 2]
    ) -> usize {
        let nk = n * k;
        for j in (1..k).rev() {
            if nk % j != 0 {
                continue;
            }
            for i in 0..k {
                let x = nk / j + i;
                if x/k * (x % k) == n {
                    return x;
                }
            }
        }
        0
    }
}
// @code end
