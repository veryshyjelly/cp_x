// @head begin
import gleam/float
import gleam/int
import gleam/list
import gleam/result
import gleam/string
// @head end

// @code begin
pub type Parse {
  ParseInt
  ParseFloat
  ParseString
  ParseWords(method: Parse)
  ParseLines(count: Int, method: Parse)
}

pub type IOResult {
  Int(Int)
  Float(Float)
  String(String)
  WordsInt(List(Int))
  WordsFloat(List(Float))
  WordsString(List(String))
  LinesInt(List(Int))
  LinesFloat(List(Float))
  LinesString(List(String))
  MatrixInt(List(List(Int)))
  MatrixFloat(List(List(Float)))
  MatrixString(List(List(String)))
}

pub fn to_string(val: IOResult) -> String {
  case val {
    Int(i) -> i |> int.to_string
    Float(f) -> f |> float.to_string
    String(s) -> s
    WordsInt(w) -> w |> list.map(int.to_string) |> string.join(" ")
    WordsFloat(w) -> w |> list.map(float.to_string) |> string.join(" ")
    WordsString(w) -> w |> string.join(" ")
    LinesInt(l) -> l |> list.map(int.to_string) |> string.join("\n")
    LinesFloat(l) -> l |> list.map(float.to_string) |> string.join("\n")
    LinesString(l) -> l |> string.join(" ")
    MatrixInt(m) ->
      m
      |> list.map(fn(w) { w |> list.map(int.to_string) |> string.join(" ") })
      |> string.join("\n")
    MatrixFloat(m) ->
      m
      |> list.map(fn(w) {
        w |> list.map(float.to_string) |> string.join(" ")
      })
      |> string.join("\n")
    MatrixString(m) ->
      m
      |> list.map(fn(w) { w |> string.join(" ") })
      |> string.join("\n")
  }
}

pub fn parse(lines: List(String), method: Parse) -> #(IOResult, List(String)) {
  let #(x, rest) = lines |> list.split(1)
  let assert Ok(x) = list.first(x)
  let assert Ok(res) = case method {
    ParseInt -> {
      use y <- result.try(x |> string.trim |> int.parse)
      Ok(#(Int(y), rest))
    }
    ParseFloat -> {
      use y <- result.try(x |> string.trim |> float.parse)
      Ok(#(Float(y), rest))
    }
    ParseString -> {
      Ok(#(String(x), rest))
    }
    ParseWords(method) -> {
      use y <- result.try(x |> parse_words(method))
      Ok(#(y, rest))
    }
    ParseLines(count, method) -> {
      let #(lines, rest) = lines |> list.split(count)
      use y <- result.try(lines |> parse_lines(method))
      Ok(#(y, rest))
    }
  }
  res
}

fn parse_words(line: String, method: Parse) -> Result(IOResult, Nil) {
  let lst = line |> string.trim |> string.split(" ")
  case method {
    ParseInt -> {
      use y <- result.try(lst |> list.try_map(int.parse))
      Ok(WordsInt(y))
    }
    ParseFloat -> {
      use y <- result.try(lst |> list.try_map(float.parse))
      Ok(WordsFloat(y))
    }
    ParseString -> {
      Ok(WordsString(lst))
    }
    _ -> Error(Nil)
  }
}

fn parse_lines(lines: List(String), method: Parse) -> Result(IOResult, Nil) {
  case method {
    ParseInt -> {
      use y <- result.try(lines |> list.try_map(int.parse))
      Ok(LinesInt(y))
    }
    ParseFloat -> {
      use y <- result.try(lines |> list.try_map(float.parse))
      Ok(LinesFloat(y))
    }
    ParseString -> {
      Ok(LinesString(lines))
    }
    ParseWords(method) -> {
      case method {
        ParseInt -> {
          use y <- result.try(
            lines
            |> list.try_map(fn(line) {
              let lst = line |> string.trim |> string.split(" ")
              use y <- result.try(lst |> list.try_map(int.parse))
              Ok(y)
            }),
          )
          Ok(MatrixInt(y))
        }
        ParseFloat -> {
          use y <- result.try(
            lines
            |> list.try_map(fn(line) {
              let lst = line |> string.trim |> string.split(" ")
              use y <- result.try(lst |> list.try_map(float.parse))
              Ok(y)
            }),
          )
          Ok(MatrixFloat(y))
        }
        ParseString -> {
          let y =
            lines
            |> list.map(fn(line) {
              let lst = line |> string.trim |> string.split(" ")
              lst
            })
          Ok(MatrixString(y))
        }
        _ -> Error(Nil)
      }
    }
    _ -> Error(Nil)
  }
}
// @code end