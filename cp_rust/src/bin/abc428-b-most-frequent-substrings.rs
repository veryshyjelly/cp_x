// Created by Ayush Biswas at 2026/07/07 11:52
// https://atcoder.jp/contests/adt_all_20260623_2/tasks/abc428_b
use cp_lib::*;

// @code begin
use cpio::*;
use std::{collections::HashMap, ops::AddAssign};

sol! {
    fn solution(
        [n, k]: [usize; 2],
        s: String
    ) -> Lines<Words<String>> {
        let mut occ: HashMap<String, usize> = HashMap::new();
        for i in 0..=n-k {
            let substr = s.get(i..i+k).unwrap().to_string();
            occ.entry(substr).or_insert(0).add_assign(1);
        }

        let max_count = *occ.values().max().unwrap();
        let mut res = vec![];
        for (k, v) in occ {
            if v == max_count {
                res.push(k);
            }
        }
        res.sort();

        vec![
            vec![max_count.to_string()].into(),
            res.into()
        ].into()
    }
}
// @code end
