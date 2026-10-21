# cp_gleam

A collection of competitive programming solutions and utilities written in [Gleam](https://gleam.run/).

## Project Structure

*   **`src/bin/`**: Contains standalone solution files for specific problems (e.g., [`abc435_a.gleam`](src/bin/abc435_a.gleam)).
*   **`src/lib/`**: Shared helper libraries, such as [`cpio`](src/lib/cpio.gleam) for streamlined Input/Output.

## Usage

### Running a Solution

Since solutions are located in `src/bin`, you can run a specific problem using the `-m` (module) flag.

For example, to run the solution for **AtCoder ABC 435 A**:

```sh
gleam run -m bin/abc435_a
```

### Input

Solutions read from standard input (`stdin`). You can pipe input via the command line:

```sh
# Example input for abc435_a
echo "3" | gleam run -m bin/abc435_a
```

Or redirect from a file:

```sh
gleam run -m bin/abc435_a < input.txt
```

## Dependencies

This project utilizes several Gleam packages to assist with algorithms and data structures:

*   `gleam_community_maths`
*   `dijkstra`
*   `bidict`
*   `bigdecimal`
*   `gleam_yielder`
