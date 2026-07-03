# 🏆 Competitive Programming Monorepo

A massive, multi-language repository of competitive programming solutions. This project serves as a sandbox for learning new languages, practicing algorithmic problem-solving, and testing workflows across different ecosystems.

> **Note:** This repository is designed to be used exclusively with **[cocom](https://github.com/veryshyjelly/cocom)**, a custom-built Go TUI companion tool. `cocom` completely abstracts away the build systems, handling everything from boilerplate generation and dependency linking to sandboxed compilation and execution.

---

## ⚡ The `cocom` Workflow

You do not need to manually run `cargo`, `dune`, `lake`, or `clang`. `cocom` reads the `cocom.yml` configuration in each language directory and handles the entire lifecycle of a problem.

### How to use this repo:
1. Install and start the `cocom` TUI inside any language directory (e.g., `cd cp_rust && cocom`).
2. Open your browser and navigate to a problem on Codeforces, AtCoder, CSES, etc.
3. Click the **Competitive Companion** browser extension.
4. `cocom` (listening on `127.0.0.1:27121`) will automatically:
   - Parse the problem URL and generate the correct filename.
   - Inject boilerplate code using language-specific templates.
   - Open your preferred external editor.
   - Fetch all sample test cases.
5. Write your solution. When you save (or press `r` in the TUI), `cocom` will automatically compile your code in an isolated sandbox, link your custom libraries, run the test cases, and display the Time/Memory metrics and AC/WA status right in the terminal.

---

## 📂 Supported Ecosystems

The repository is divided into language-specific directories. Each contains its own standard library, build configuration, and `cocom.yml` rules.

| Language | Directory | Internal Library / IO |
| :--- | :--- | :--- |
| 🦀 **Rust** | `cp_rust/` | `src/lib/` (Algorithms, Data Structures, `cpio`) |
| 🐍 **Python** | `cp_python/` | `cpio/` (Fast I/O parsing) |
| 🐫 **OCaml** | `cp_ocaml/` | `src/lib/` (Dune managed) |
| 📐 **Lean 4** | `cp_lean/` | `Src/` (`Cpio.lean`, `Dsu.lean`) |
| ✨ **Gleam** | `cp_gleam/` | `src/lib/` (`cpio`, `memo`) |
| 🧮 **C++** | `cp_cpp/` | `src/lib/` (AC-Library based) |
| 🦦 **Haskell** | `cp_haskell/`| `Main.hs` |
| ⚙️ **ARM64 Asm**| `cp_arm/` | `main.s` (Apple Silicon) |
| 🐉 **LLVM IR** | `cp_llvm/` | `lib/` |

---

## 🧠 Anatomy of a Language Folder

Every `cp_*` directory is structured to be consumed by `cocom`'s internal engine:

### 1. `cocom.yml` (The Brain)
This file tells `cocom` how to handle the language. It defines:
- **Filename Rules:** Regex patterns to map URLs (e.g., `codeforces.com/contest/...`) to local filenames (e.g., `1999-a-a-b-again.rs`).
- **Compiler Args:** The exact commands `cocom` needs to build and run the sandboxed binary.
- **Editor:** The shell command to open your IDE (e.g., `nvim`, `code`, `zed`).

### 2. The Linker (`lib/` or `src/lib/`)
`cocom` features a built-in dependency linker. If your solution includes a library file, `cocom` will:
1. Scan the library directory.
2. Topologically sort dependencies to prevent circular imports.
3. Extract code blocks marked with `@code begin` / `@code end`.
4. Extract headers marked with `@head begin` / `@head end`.
5. Merge and deduplicate them into your final submission file automatically.

### 3. Templates
Boilerplate generation is handled via Go `text/template` modifiers defined in the YAML, allowing you to inject the Author, Date, Problem URL, and linked library code directly into your new file.

---

## 🧪 Bulk Test Case Fetching

While `cocom` handles test case parsing from the browser on the fly, several directories include standalone Python scripts to bulk-download entire problem sets (like the CSES problem set or AOJ) for offline practice.

Look for scripts named `fetch_test_cases_*.py` in the root of the respective language directories:
```bash
python3 fetch_test_cases_cses.py
python3 fetch_test_cases_aizu.py
```

---

## 🤝 Contributing

Contributions, optimizations, and new language additions are welcome! 
1. Fork the repository.
2. Create a new branch (`git checkout -b feature/new-language`).
3. Add your `cocom.yml`, templates, and library files.
4. Ensure the workflow functions correctly within the `cocom` TUI.
5. Open a Pull Request.

---

## 📜 License

This repository is open source and available under the [MIT License](LICENSE).
