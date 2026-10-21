// Created by Ayush Biswas at 2026/07/12 20:40
// https://codeforces.com/contest/2246/problem/D
use cp_lib::*;

// @code begin
use cpio::*;

sol_n! {
    fn solution(
        n: usize,
        (mut a): [usize]
    ) -> usize {
        let b = a.clone();
        let mut moves = 0;
        for i in 0..n {
            if a[i] % 2 != 0 {
                a[i] += 1;
                moves += 1;
            }
        }
        while a.iter().all(|ai| ai % 2 == 0) {
            a.iter_mut().for_each(|ai| *ai = *ai/2);
            moves += 1;
        }
        // dbg!(moves)
        let a_answer = (a.into_iter()
            .map(|ai| (ai.ilog2() + ai.count_ones()) as usize)
            .sum::<usize>()
        +
        moves);

        let b_answer =
            b.into_iter()
                        .map(|bi| (bi.ilog2() + bi.count_ones()) as usize)
                        .sum::<usize>();

        a_answer.min(b_answer)
    }
}
// @code end
