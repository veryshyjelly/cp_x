# 🏆 ClojureScript

This branch contains competitive programming solutions written in ClojureScript.

## Repository Structure
- `src/lib/` - ClojureScript standard library and utilities
- `src/bin/` - Individual problem solutions (ac_abc175_b.cljs, ac_abc180_c.cljs, etc.)
- `eitri.yml` - Configuration for the eitri tool
- `.gitignore` - Git ignore rules
- `.vscode/settings.json` - VS Code configuration

## Getting Started
1. Ensure you have Node.js and npm installed
2. Install dependencies: `npm install`
3. Run solutions using: `clj -M -m cljs.main <problem-file>`
4. Or use the eitri tool

## Supported Problems
This branch includes solutions for various platforms including:
- Codeforces problems
- AtCoder problems
- CSES problem set

## Development
- Uses ClojureScript with reader conditionals
- Fast I/O parsing with custom cpio implementation
- Browser-compatible code generation

## License
This repository is open source and available under the [MIT License](LICENSE).
