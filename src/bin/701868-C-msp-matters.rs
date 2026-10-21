// Created by Ayush Biswas at 2026/07/05 21:50
// https://codeforces.com/gym/701868/problem/C
use cp_lib::*;

// @code begin
use binary_search::search_right;
use cpio::*;

sol_n! {
    fn solution(
        n: usize,
        (mut a): [usize]
    ) -> usize {
        if n <= 3 {
            return 0;
        }
        a.sort();

    let check = |r: usize| -> bool {
        let mut i = 0;

        for _ in 0..3 {
            if i == n {
                return true;
            }

            let limit = a[i] + 2 * r;

            while i < n && a[i] <= limit {
                i += 1;
            }
        }

        i == n
    };

        search_right(0, 10usize.pow(9), check)
    }
}
// @code end
