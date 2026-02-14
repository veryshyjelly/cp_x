# cp_lean

Competitive programming solutions in Lean 4, with a small IO helper layer for ergonomic parsing and running inside VS Code.

## Requirements

- Lean 4 and Lake (via `elan`)
- VS Code + Lean 4 extension (recommended)
- macOS (tested)

## Setup

```bash
# clone and enter
git clone https://github.com/veryshyjelly/cp_lean.git
cd cp_lean

# build (downloads toolchain if needed)
lake build
```

If you don’t have Lean/Lake, install via elan:
```bash
curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh
```

## Run

Use `lake env lean --run` to execute a file with a `main`:
```bash
# run with stdin
lake env lean --run Src/Bin/Arc058A.lean < input.txt

# or pipe an example
printf "1000 8\n1 3 4 5 6 7 8 9\n" | lake env lean --run Src/Bin/Arc058A.lean
```

## Project Layout

- `Src/Cpio.lean` — small helper for parsing input and running solutions
- `Src/Bin/Arc058A.lean` — AtCoder ARC058 A / ABC042 C “Iroha’s Obsession”

## Example: ARC058 A (ABC042 C)

Problem: Given `N` and a set of forbidden digits `D`, find the smallest integer `x ≥ N` whose decimal digits do not contain any digit from `D`.

Implementation highlights:
- `digits` collects digits of a number into a `HashSet Nat`.
- `solution`:
  - Parses `N`, `K`, and the list of forbidden digits.
  - Builds a `HashSet` of forbidden digits.
  - Scans from `N` upward to find the first number whose digits avoid the forbidden set.
- `main` wires the solution through `CPio.solve`, using `Splitter.NoSplitting` to keep input lines as-is.

File:
- `Src/Bin/Arc058A.lean`

Input format (as used by the solution):
- Line 1: `N K`
- Line 2: `K` digits (space-separated)

Example:
```
Input:
1000 8
1 3 4 5 6 7 8 9

Output:
2000
```

## Add a new problem

- Create `Src/Bin/<ProblemName>.lean` with a `main : IO Unit`.
- Use `CPio.solve` to handle IO similarly to `Arc058A.lean`.
- Keep parsing and pure logic separate for clarity.

## VS Code Tips

- Open the folder in VS Code.
- Ensure the Lean 4 extension is enabled.
- Use the integrated terminal to run `lake env lean --run ...`.
- Problems and warnings show inline via the Lean server.

## License

Personal use; adapt as needed.