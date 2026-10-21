// Created by Ayush Biswas at 2026/07/06 20:15
// https://codeforces.com/contest/2242/problem/B
use cp_lib::*;

// @code begin
use cpio::*;

sol_n! {
    fn solution(
        n: usize,
        a: [usize]
    ) -> String {
        let mut one_count = 0;
        let mut i = 0;
        let mut possible_js = vec![];
        while i < n {
            if a[i] == 1 {
                one_count += 1;
            }
            i += 1;
            if one_count * 2 >= i {
                possible_js.push(i);
            }
        }
        if possible_js.is_empty() {
            dbg!("no pass");
            return "NO".into();
        }
        // dbg!(possible_js.clone());
        for i in possible_js {
            let mut j = i;
            // dbg!(j);
            let mut two_count = 0;
            while j < n - 1 {
                if a[j] <= 2 {
                    two_count += 1;
                }
                j += 1;
                // dbg!(two_count, j, i);
                if two_count * 2 >= j - i {
                    return "YES".into();
                }
            }
        }

        "NO".into()
    }
}
// @code end
