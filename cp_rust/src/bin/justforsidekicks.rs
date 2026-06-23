// Created by Ayush Biswas at 2026/05/09 13:53
// https://open.kattis.com/problems/justforsidekicks
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;
use monoid::Monoid;
use segtree::SegTree;

struct Freq;

impl Monoid for Freq {
    type S = [usize; 6];
    fn identity() -> Self::S {
        [0; 6]
    }
    fn binary_operation(a: &Self::S, b: &Self::S) -> Self::S {
        a.iter().zip(b.iter())
            .map(|(ai, bi)| ai + bi)
            .collect_vec()
            .try_into()
            .unwrap()
    }
}

sol! {
    fn solution(
        [n, q]: [usize; 2],
        (mut values): [usize; 6],
        gems: [char],
        queries: [[usize; 3]; q]
    ) -> Lines<usize> {
        let new_gems = gems.into_iter().map(|gem| {
            let mut gi = [0; 6];
            gi[gem.to_digit(10).unwrap() as usize - 1] = 1;
            gi
        }).collect_vec();
        let mut tree: SegTree<Freq> = SegTree::from(new_gems);
        let mut res = vec![];
        for query in queries {
           if query[0] == 1 {
                let [_, k, p] = query;
                let mut gi = [0; 6];
                gi[p - 1] = 1;
                tree.set(k - 1, gi);
           } else if query[0] == 2 {
                let [_, p, v] = query;
                values[p - 1] = v;
           } else if query[0] == 3 {
                let [_, l, r] = query;
                let [l, r] = [l - 1, r - 1];
                let freq = tree.prod(l..=r);
                let summ = values.iter().zip(freq).map(|(vi, fi)| vi * fi).sum::<usize>();
                res.push(summ);
            }
        }
        res.into()
    }
}

// @code end
