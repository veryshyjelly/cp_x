// Created by Ayush Biswas at 2026/05/19 09:27
// https://codeforces.com/problemset/problem/545/C
use cp_lib::*;

// @code begin
use cpio::*;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

#[derive(Clone, Default)]
struct Fell {
    stay: usize,
    left: usize,
    right: usize,
}

sol! {
    fn solution(
        n: usize,
        coors: [[isize; 2]; n]
    ) -> usize {
        let mut dp = vec![Fell::default(); n];
        dp[0].stay = 1;
        dp[0].left = 1;
        dp[0].right = 1;

        for i in 1..n {
            let [prev_cor, prev_h] = coors[i - 1];
            let [curr_cor, curr_h] = coors[i];
            let prev_fell = prev_cor + prev_h;
            let left_fell = curr_cor - curr_h;
            if prev_fell < curr_cor {
                dp[i].stay = dp[i - 1].left.max(dp[i - 1].right).max(dp[i - 1].stay);
            } else {
                dp[i].stay = dp[i - 1].left.max(dp[i - 1].stay);
            }
            if left_fell > prev_cor {
                dp[i].left = dp[i - 1].stay.max(dp[i - 1].left) + 1;
                if left_fell > prev_fell {
                    dp[i].left = dp[i].left.max(dp[i - 1].right + 1);
                }
            }
            dp[i].right = dp[i].stay + 1;
        }

        dp[n - 1].stay.max(dp[n - 1].left).max(dp[n - 1].right)
    }
}

// @code end
