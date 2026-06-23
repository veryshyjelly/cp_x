// Created by Ayush Biswas at 2026/05/23 20:29
// https://codeforces.com/problemset/problem/977/E
use cp_lib::*;

// @code begin
use cpio::*;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol! {
    fn solution(
        [n, m]: [usize; 2],
        edges: [[usize; 2]; m]
    ) -> usize {
        let mut graph = vec![vec![]; n + 1];
        for [a, b] in edges {
            graph[a].push(b);
            graph[b].push(a);
        }

        let mut res = 0;
        let mut visited = vec![false; n + 1];
        for i in 1..=n {
            if visited[i] {
                continue;
            }

            let mut stack = vec![i];
            let mut not_cycle = false;

            while let Some(node) = stack.pop() {
                if graph[node].len() != 2 {
                    not_cycle = true;
                }

                for &neighbor in &graph[node] {
                    if visited[neighbor] {
                        continue;
                    }

                    visited[neighbor] = true;
                    stack.push(neighbor);
                }
            }

            if !not_cycle {
                res += 1;
            }
        }

        res
    }
}

// @code end
