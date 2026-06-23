// Created by Ayush Biswas at 2026/05/24 11:18
// https://codeforces.com/problemset/problem/166/E
use cp_lib::*;

// @code begin
use cpio::*;
const MOD: usize = 10usize.pow(9) + 7;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol! {
    fn solution(
        n: usize,
    ) -> usize {
        let mat = vec![
            vec![0, 3],
            vec![1, 2]
        ];
        matpow(mat, n)[0][0]
    }
}

fn matmul(a: &Vec<Vec<usize>>, b: &Vec<Vec<usize>>) -> Vec<Vec<usize>> {
    let n = a.len();
    let m = a[0].len();
    let p = b.len();
    let q = b[0].len();
    assert_eq!(m, p);
    let mut res = vec![vec![0; q]; n];
    for i in 0..n {
        for j in 0..q {
            for k in 0..m {
                res[i][j] = (res[i][j] + a[i][k] * b[k][j]) % MOD;
            }
        }
    } 
    res
}

fn identity(n: usize) -> Vec<Vec<usize>> {
    let mut id = vec![vec![0; n]; n];

    for i in 0..n {
        id[i][i] = 1;
    }

    id
}

fn matpow(mut base: Vec<Vec<usize>>, mut exp: usize) -> Vec<Vec<usize>> {
    let n = base.len();

    let mut result = identity(n);

    while exp > 0 {
        if exp & 1 == 1 {
            result = matmul(&result, &base);
        }

        base = matmul(&base, &base);

        exp >>= 1;
    }

    result
}

// @code end
