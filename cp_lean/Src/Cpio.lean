namespace CPio

open IO FS

/-- Parser type class to handle lines of input for a single test case. -/
class Parser (α : Type) where
  parse : List String → α

/-- Formatter type class to format output for a single test case. -/
class Formatter (α : Type) where
  format : α → String

/-- Splitter type to segment the input into multiple test cases. -/
inductive Splitter
  | NoSplitting -- ^ No splitting, the entire input is a single test case.
  | EqualSized -- ^ Split into equal sized test cases. T is in line 1.
  | FixedSized (n : Nat) -- ^ Split into fixed sized test cases. T is in line 1.
  | DynamicSized (f : List Int → Nat) -- ^ Split based on logic from the first line of the case.

/-- Configuration to handle input/output and splitting. -/
structure Config where
  input    : Option System.FilePath := none
  output   : Option System.FilePath := none
  splitter : Splitter := Splitter.EqualSized

/-- Default configuration: stdin/stdout and equal sized splitting. -/
def withConfig : Config := {}

/-- Solution type: A pure function mapping input to output. -/
def Solution (i : Type) (o : Type) := i → o

/-- Helper to split a string into words, ignoring empty chunks. -/
def String.fields (s : String) : List String :=
  s.splitOn " " |>.filter (· ≠ "")

-- ** Parsers
/-- Parse as lines of Strings. -/
instance : Parser (List String) where
  parse := id

instance : Parser (List Int) where
  parse lines := lines.map λ x => x.toInt!

/-- Parse as lines of words of Strings. -/
instance : Parser (List (List String)) where
  parse lines := lines.map String.fields

/-- Parse as lines of multiple Naturals. -/
instance : Parser (List (List Nat)) where
  parse lines := lines.map fun l => (String.fields l).map String.toNat!

/-- Parse as lines of multiple Integers. -/
instance : Parser (List (List Int)) where
  parse lines := lines.map fun l => (String.fields l).map String.toInt!

instance : Parser (Int × List (List String)) where
  parse lines :=
    match lines with
    | [] => (0, [])
    | h :: t => (h.toInt!, Parser.parse t)

/-- Parse first line as String, rest as Matrix of Ints. -/
instance : Parser (String × List (List Int)) where
  parse lines :=
    match lines with
    | [] => ("", [])
    | h :: t => (h, Parser.parse t)

-- ** Formatters

/-- Format a String as itself. -/
instance : Formatter String where
  format := id

/-- Format an Integer as String. -/
instance : Formatter Int where
  format := toString

/-- Format a Bool as "YES" or "NO". -/
instance : Formatter Bool where
  format b := if b then "YES" else "NO"

/-- Wrapper to control List formatting. -/
inductive ListOf (α : Type)
  | WordsOf (data : List α)
  | LinesOf (data : List α)

/-- Format a list of values either on a single line or multiple lines. -/
instance [Formatter α] : Formatter (ListOf α) where
  format
    | ListOf.WordsOf xs => String.intercalate " " (xs.map Formatter.format)
    | ListOf.LinesOf xs => String.intercalate "\n" (xs.map Formatter.format)

-- ** Splitters

/-- Helper for dynamic splitting. -/
partial def dynamicSplit (f : List Int → Nat) (lines : List String) : List (List String) :=
  match lines with
  | [] => []
  | (h :: t) =>
    let headerInts := (String.fields h).map String.toInt!
    let size := f headerInts
    let (caseLines, rest) := t.splitAt size
    caseLines :: dynamicSplit f rest

/-- Split the input lines into multiple test cases. -/
partial def splitWith (splitter : Splitter) (lines : List String) : List (List String) :=
  match splitter, lines with
  | Splitter.NoSplitting, xs => [xs]
  | Splitter.EqualSized, (x :: xs) =>
    let t := x.toInt!
    let n := if t > 0 then xs.length / t.toNat else 0
    splitWith (Splitter.FixedSized n) (x :: xs)
  | Splitter.FixedSized n, (_ :: xs) =>
    dynamicSplit (fun _ => n) xs
  | Splitter.DynamicSized f, (_ :: xs) =>
    dynamicSplit f xs
  | _, [] => []

-- ** The Main Logic

/-- Core pure logic: split, parse, solve, format, join. -/
partial def solvePure [Parser i] [Formatter o]
    (splitter : Splitter) (inputData : String) (sol : Solution i o) : String :=
  let lines := (inputData.splitOn "\n").filter (· ≠ "")
  let cases := splitWith splitter lines
  let results := cases.map fun c => Formatter.format (sol (Parser.parse c))
  String.intercalate "\n" results

/-- Main side-effecting function. -/
partial def solve [Parser i] [Formatter o] (cfg : Config) (solution : Solution i o) : IO Unit := do
  let inputHandle ← getStdin
  let outputHandle ←  getStdout

  let content ← inputHandle.readToEnd
  let result := solvePure cfg.splitter content solution

  outputHandle.putStr result
  if cfg.output.isNone then outputHandle.putStr "\n" -- Add newline for stdout
end CPio

axiom given {P : Prop} : P
