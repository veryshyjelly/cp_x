// Created by Ayush Biswas at 2026/05/18 18:24
// https://cses.fi/problemset/task/1735
use cp_lib::*;

// @code begin

use cpio::*;
use lazysegtree::*;

sol! {
    fn solution(
        [n, q]: [usize; 2],
        a: [isize],
        queries: [[usize]; q]
    ) -> Lines<isize> {
        let mut tree: RangeSetAddSumTree<isize> = RangeSetAddSumTree::from_values(a);
        let mut res = vec![];
        for query in queries {
            if query[0] == 1 {
                let [a, b, c] = [query[1], query[2], query[3]];
                tree.range_add((a - 1..=b - 1), c as isize);
            } else if query[0] == 2 {
                let [a, b, c] = [query[1], query[2], query[3]];
                tree.range_set((a - 1..=b - 1), c as isize);
            } else if query[0] == 3 {
                let [a, b] = [query[1], query[2]];
                res.push(tree.range_sum((a - 1..=b - 1)));
            }
        }
        res.into()
    }
}

// @code end
