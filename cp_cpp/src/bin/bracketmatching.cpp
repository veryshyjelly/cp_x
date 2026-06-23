// Created by Ayush Biswas at 2026/04/17 20:37
// https://open.kattis.com/problems/bracketmatching

/// @head begin
#include <iostream>
#include <stack>
#include <map>
/// @head end

/// @code begin
using namespace std;

void solve(const int n, const string& s) {
    map<char, char> closed = {
        {')', '('},
        {']', '['},
        {'}', '{'}
    };

    stack<char> st;
    for (auto c : s) {
        if (closed.contains(c)) {
            if (st.empty() || st.top() != closed[c]) {
                cout << "Invalid";
                return;
            }
            st.pop();
        } else {
            st.push(c);
        }
    }
    if (st.empty()) {
        cout << "Valid";
    } else {
        cout << "Invalid";
    }
}

int main() {
    cin.tie(nullptr);

    int n;
    cin >> n;
    string s;
    cin >> s;

    solve(n, s);
    return 0;
}
/// @code end
