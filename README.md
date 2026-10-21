# 🏆 ARM64 Assembly (macOS)

This branch contains competitive programming solutions written in ARM64 Assembly language, primarily for macOS systems with Apple Silicon architecture.

## Why ARM64 Assembly?
AOJ (Aizu Online Judge) provides full public test cases for their problems, making it easier to verify and debug assembly solutions locally. Problems from other sites may also be solved and included here.

## Repository Structure
- `src/` - Contains all assembly solutions, named according to the problem source and title
- `main.s` - Template/main entry point for assembly programs
- `eitri.yml` - Configuration for the cocom tool
- `fetch_test_cases.py` - Script to fetch AOJ test cases for local testing
- `.gitignore` - Git ignore rules

## Getting Started
1. **Requirements:**
   - macOS with ARM64 (Apple Silicon)
   - `clang` for assembling and linking
   - Python 3 (for test case scripts)
   - [Requests](https://pypi.org/project/requests/) and [tqdm](https://pypi.org/project/tqdm/) Python packages

2. **Building and Running:**
   - Assemble and link an assembly file:
     ```sh
     clang -o a.out src/<problem-file>.s main.s
     ./a.out
     ```
   - Use `fetch_test_cases.py` to download AOJ test cases for local validation.

3. **Workflow:**
   - Write your solution in ARM64 assembly in the `src/` folder.