// Created by Ayush Biswas at 2026/07/27 16:47
// https://atcoder.jp/contests/adt_all_20260623_2/tasks/abc428_b
// D - Most Frequent Substrings


use cpio::*;
use itertools::Itertools;

sol! {
    fn solution(
        n: usize, k: usize,
        s: Chars
    ) -> Lines<Words<String>> {
        let all_strings = s.windows(k).map(|w|
            w.iter().collect::<String>()
        ).counts();
        let max_occ = *all_strings.values().max().unwrap();
        let occured = all_strings.into_iter().filter_map(|(k, v)|
            if v == max_occ { Some(k) }
            else {None}
        );
        vec![
            vec![max_occ.to_string()].into(),
            occured.sorted().collect()
        ].into()
    }
}
