// Created by Ayush Biswas at 2026/05/06 13:20
// https://open.kattis.com/problems/fendofftitan
/// @head begin
#include <iostream>
#include <vector>
#include <queue>
/// @head end

/// @code begin
using namespace std;

#define ll long long

struct Road {
    int dest;
    ll distance;
    int enemy;
};

void solve() {
    int village_count, road_count, source, sink;
    cin >> village_count >> road_count;
    cin >> source >> sink;
    vector<vector<Road>> graph(village_count + 1);
    for (int i = 0; i < road_count; i++) {
        int a, b, w, c;
        cin >> a >> b >> w >> c;
        graph[a].push_back({b, w, c});
        graph[b].push_back({a, w, c});
    }

    using Cost = tuple<ll, ll, ll>;
    constexpr ll INF = numeric_limits<ll>::max();

    vector<Cost> dist(village_count + 1, {INF, INF, INF});
    priority_queue<pair<Cost, int>, vector<pair<Cost, int>>, greater<>> pq;
    dist[source] = {0, 0, 0};
    pq.push({dist[source], source});

    while (!pq.empty()) {
        auto [cost, u] = pq.top();
        pq.pop();

        if (cost != dist[u]) continue;

        auto [titans, shins, len] = cost;

        for (auto &e : graph[u]) {
            ll new_titans = titans + (e.enemy == 2);
            ll new_shins = shins + (e.enemy == 1);
            ll new_len = len + e.distance;
            Cost nxt = {new_titans, new_shins, new_len};
            if (nxt < dist[e.dest]) {
                dist[e.dest] = nxt;
                pq.push({nxt, e.dest});
            }
        }
    }

    if (get<0>(dist[sink]) == INF) {
        cout << "IMPOSSIBLE";
    } else {
        auto [titans, shins, len] = dist[sink];
        cout << len << " " << shins << " " << titans;
    }
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    solve();
}
/// @code end
