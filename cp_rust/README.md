# Competitive Programming Solutions in Rust

This repository contains solutions to various competitive programming problems, primarily from [Codeforces](https://codeforces.com/), implemented in Rust. It features a custom library of common algorithms and data structures to streamline problem-solving.

## Project Structure

-   `src/bin/`: Each file in this directory is a standalone executable solution for a specific problem. The filenames usually correspond to the problem ID from the online judge.
-   `src/lib/`: A comprehensive support library (`cp_lib`) containing modules for various algorithms and data structures like graph traversals (BFS, DFS), shortest paths (Dijkstra), data structures (Segment Tree, Fenwick Tree), and more.
-   `fetch_test_cases_*.py`: Python scripts to automatically download sample test cases for problems from [CSES](https://cses.fi/problemset/) and [Aizu Online Judge](https://onlinejudge.u-aizu.ac.jp/home).
-   `Cargo.toml`: The Rust project configuration file.

## Usage

### Running a Solution

You can run any solution using its filename (without the `.rs` extension) as the binary name with Cargo.

1.  **Find the binary name**: Look at the filename in `src/bin/`. For example, `1791-a-codeforces-checking.rs`.
2.  **Run with Cargo**: Use `cargo run --bin <binary-name>`.

```bash
# Example for src/bin/1791-a-codeforces-checking.rs
cargo run --bin 1791-a-codeforces-checking
```

The program will then wait for input from stdin.

### Adding a New Solution

1.  Create a new file in the `src/bin/` directory (e.g., `src/bin/PROBLEM_ID.rs`).
2.  Use the following template for your solution. The `sol_n!` macro is used to handle I/O, so you only need to focus on the core logic.

    ```rust
    // Created by [Your Name] at YYYY/MM/DD HH:MM
    // [Problem URL]
    use cp_lib::*;

    // @code begin
    use cpio::*;

    sol_n! {
        fn solution(
            // ...input arguments based on the problem
        ) -> // return type
        {
            // ...your solution logic
        }
    }

    // @code end
    ```

3.  Place your problem-solving logic inside the `solution` function. The `cpio` module and the `sol_n!` macro will handle reading the input and printing the output.

## Helper Scripts

The repository includes Python scripts to fetch sample test cases.

### Prerequisites

Make sure you have Python 3 and the required libraries installed:

```bash
pip install requests beautifulsoup4
```

### Running the Scripts

Execute the scripts from the root directory, passing the problem ID as an argument.

```bash
# For a CSES problem
python3 fetch_test_cases_cses.py <problem_id>

# For an Aizu Online Judge problem
python3 fetch_test_cases_aizu.py <problem_id>
```

The scripts will create `in/` and `out/` subdirectories containing the fetched test case files.
