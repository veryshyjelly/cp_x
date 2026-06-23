// Created by Ayush Biswas at 2026/05/23 09:05
// https://codeforces.com/problemset/problem/1418/C
use cp_lib::*;

// @code begin
use cpio::*;
// const INF: u32 = 10u32.pow(9);
const INF: usize = 4 * 10usize.pow(18);

sol_n! {
    fn solution(
        n: usize,
        a: [usize]
    ) -> usize {
        let mut dp = vec![[INF; 2]; n + 1];
        dp[0][1] = 0;
        for i in 0..n {
            for player in 0..=1 {
                for kills in 1..=2.min(n - i) {
                    let hards = if kills > 1 {
                        a[i] + a[i + 1]
                    } else {
                        a[i]
                    };
                    dp[i + kills][1 - player] = dp[i + kills][1 - player].min(
                        dp[i][player] + hards*player
                    );
                }
            }
        }
        dp[n][1].min(dp[n][0])
    }
}

// @code end
