// Created by Ayush Biswas at 2026/05/18 18:34
// https://cses.fi/problemset/task/1144
use cp_lib::*;

// @code begin
use cpio::*;
use monoid::Additive;
use segtree::SegTree;
use std::collections::HashMap;

sol! {
    fn solution(
        [n, q]: [usize; 2],
        (mut salaries): [usize],
        queries: [[String; 3]; q]
    ) -> Lines<isize> {
        let mut coors = salaries.clone();
        let mut quarrels = Vec::with_capacity(queries.len());
        for [q, a, b] in queries {
            let a: usize = a.parse().unwrap();
            let b: usize = b.parse().unwrap();
            if q == "!" {
                coors.push(b);
                quarrels.push([1, a - 1, b])
            } else {
                coors.push(a);
                coors.push(b);
                quarrels.push([2, a, b]);
            }
        }

        coors.sort();
        coors.dedup();
        let compressed: HashMap<usize, usize> =
            coors.into_iter().enumerate().map(|(i, v)| (v, i)).collect();

        let mut tree: SegTree<Additive<isize>> = SegTree::new(compressed.len());
        for s in &salaries {
            tree.set(compressed[s], tree.get(compressed[s])+1);
        }

        let mut res = vec![];
        for [q, a, b] in quarrels {
            if q == 1 {
                let prev_idx = compressed[&salaries[a]];
                tree.set(prev_idx, tree.get(prev_idx)-1);
                let curr_idx = compressed[&b];
                tree.set(curr_idx, tree.get(curr_idx)+1);
                salaries[a] = b;
            } else if q == 2 {
                let start = compressed[&a];
                let end = compressed[&b];
                res.push(tree.prod((start..=end)));
            }
        }

        res.into()
    }
}

// @code end
