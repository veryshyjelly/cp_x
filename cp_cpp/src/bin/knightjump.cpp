// Created by Ayush Biswas at 2026/05/06 14:13
// https://open.kattis.com/problems/knightjump
/// @head begin
#include <iostream>
#include <vector>
#include <queue>
#include <set>
/// @head end

/// @code begin
#define vi vector<int>
#define pi pair<int, int>
#define ll long long

using namespace std;

void solve() {
    int n; cin >> n;
    set<pi> blocked;
    pi start;
    for (int i = 0; i < n; i++) {
        string l; cin >> l;
        for (int j = 0; j < n; j++) {
            if (l[j] == '#') {
                blocked.insert({i, j});
            } else if (l[j] == 'K') {
                start = {i, j};
            }
        }
    }

    vector<pi> moves = {
        {1, 2}, {1, -2}, {2, 1}, {2, -1},
        {-1, 2}, {-1, -2}, {-2, 1}, {-2, -1}
    };
    constexpr ll INF = numeric_limits<ll>::max();
    vector<vector<ll>> dist(n, vector<ll>(n, INF));
    dist[start.first][start.second] = 0;
    queue<pi> q; q.push(start);
    while (!q.empty()) {
        auto [x, y] = q.front(); q.pop();
        auto d = dist[x][y];
        for (auto [dx, dy] : moves) {
            pi next = {x + dx, y + dy};
            if (blocked.contains(next)) continue;
            if (dist[next.first][next.second] > d + 1) {
                dist[next.first][next.second] = d + 1;
                q.push(next);
            }
        }
    }
    if (dist[0][0] == INF) {
        cout << -1;
    } else {
        cout << dist[0][0];
    }
}

int main() {
    cin.tie(nullptr);

    solve();
}
/// @code end
