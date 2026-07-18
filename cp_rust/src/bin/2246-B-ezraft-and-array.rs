// Created by Ayush Biswas at 2026/07/12 20:11
// https://codeforces.com/contest/2246/problem/B
use cp_lib::*;

// @code begin
use cpio::*;

sol_n! {
    fn solution(
        n: usize,
    ) -> CPResult<Words<usize>, isize> {
        if n == 1 {
            return Success(vec![1].into());
        }
        if n == 2 {
            return Failure(-1);
        }
        let mut res = vec![0; n];
        res[0] = 1;
        res[1] = 2;
        res[2] = 3;
        for i in 3..n {
            res[i] = 2*res[i - 1];
        }

        Success(res.into())
    }
}
// @code end
