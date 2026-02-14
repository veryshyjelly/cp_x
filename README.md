# Competitive Programming Solutions

This repository is a collection of competitive programming solutions in various languages. Each language has its own dedicated directory, containing solutions to problems from platforms like Codeforces, AtCoder, Aizu Online Judge (AOJ), and CSES.

## Languages

This repository includes solutions in the following languages:

- [ARM64 Assembly](#competitive-programming-in-arm64-assembly-macos)
- [Gleam](#cp_gleam)
- [Lean](#cp_lean)
- [Python](#cp_python)
- [Rust](#competitive-programming-solutions-in-rust)

## Directory Structure

The repository is organized by language, with each language having its own subdirectory:

```
.
├── cp_arm/
├── cp_gleam/
├── cp_lean/
├── cp_python/
└── cp_rust/
```

Each language-specific directory contains the solutions, helper scripts, and its own README with more detailed information.

---

## Competitive Programming in ARM64 Assembly (macOS)

This directory contains solutions to competitive programming problems in ARM64 assembly language, intended to run on macOS systems with Apple Silicon.

### Repository Structure

-   `src/`: Contains all assembly solutions.
-   `main.s`: Template/main entry point for assembly programs.
-   `fetch_test_cases.py`: Script to fetch AOJ test cases.
-   `config.toml`: Configuration for naming, templates, and workflow.

### Getting Started

1.  **Requirements:**
    -   macOS with ARM64 (Apple Silicon)
    -   `clang` for assembling and linking
    -   Python 3, `requests`, and `tqdm`

2.  **Building and Running:**
    ```sh
    clang -o a.out src/<problem-file>.s main.s
    ./a.out
    ```

For more details, see the [ARM assembly README](./cp_arm/README.md).

---

## cp_gleam

A collection of competitive programming solutions and utilities written in [Gleam](https://gleam.run/).

### Project Structure

-   `src/bin/`: Contains standalone solution files for specific problems.
-   `src/lib/`: Shared helper libraries, such as `cpio` for streamlined Input/Output.

### Usage

To run a specific problem solution:

```sh
gleam run -m bin/<problem_name>
```

For more details, see the [Gleam README](./cp_gleam/README.md).

---

## cp_lean

Competitive programming solutions in Lean 4, with a small IO helper layer for ergonomic parsing.

### Requirements

-   Lean 4 and Lake (via `elan`)
-   VS Code + Lean 4 extension (recommended)

### Run

Use `lake env lean --run` to execute a file with a `main`:

```sh
lake env lean --run Src/Bin/<ProblemName>.lean < input.txt
```

For more details, see the [Lean README](./cp_lean/README.md).

---

## cp_python

This directory contains competitive programming solutions written in Python.

### Project Structure

-   `src/`: Contains the solution files.
-   `cpio/`: A library for input/output handling.
-   `fetch_test_cases_*.py`: Scripts to download sample test cases.

### Usage

To run a solution:

```sh
python3 src/<problem_file>.py
```

---

## Competitive Programming Solutions in Rust

This repository contains solutions to various competitive programming problems, implemented in Rust.

### Project Structure

-   `src/bin/`: Each file is a standalone executable solution for a specific problem.
-   `src/lib/`: A support library (`cp_lib`) containing common algorithms and data structures.
-   `fetch_test_cases_*.py`: Python scripts to automatically download sample test cases.

### Usage

You can run any solution using its filename (without the `.rs` extension) as the binary name with Cargo.

```sh
cargo run --bin <binary-name>
```

For more details, see the [Rust README](./cp_rust/README.md).

---

## Contributing

Contributions are welcome! If you have a solution to a problem in a new or existing language, feel free to open a pull request.

## License

This repository is open source and available under the [MIT License](LICENSE).
