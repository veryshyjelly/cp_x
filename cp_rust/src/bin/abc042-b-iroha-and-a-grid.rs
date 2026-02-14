// Created by Ayush Biswas at 2026/01/20 14:45
// https://atcoder.jp/contests/abc042/tasks/arc058_b
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;
use modint::ModInt1000000007;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol! {
    fn solution(
        [h, w, a, b]: [usize; 4]
    ) -> u32 {
        let comb = NCR::new(2*100000);
        (b..w).map(|i| comb.num_ways(h - a - 1, i) * comb.num_ways(a - 1, w - i - 1))
              .sum::<ModInt1000000007>().val()
    }
}

struct NCR {
    factorials: Vec<ModInt1000000007>,
}

impl NCR {
    pub fn new(n: usize) -> Self {
        let f = (0..=n)
            .scan(ModInt1000000007::new(1), |state, x| {
                if x != 0 {
                    *state *= x;
                }
                Some(*state)
            })
            .collect_vec();

        NCR { factorials: f }
    }

    fn ncr(&self, n: usize, r: usize) -> ModInt1000000007 {
        self.factorials[n] * self.factorials[r].inv() * self.factorials[n - r].inv()
    }

    pub fn num_ways(&self, x: usize, y: usize) -> ModInt1000000007 {
        self.factorials[x + y] * self.factorials[x].inv() * self.factorials[y].inv()
    }
}

// @code end
