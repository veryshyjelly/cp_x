import gleam/float as float_
import gleam/int as int_
import gleam/list as list_
import gleam/result as result_
import gleam/string as string_

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
    Int(i) -> i |> int_.to_string
    Float(f) -> f |> float_.to_string
    String(s) -> s
    WordsInt(w) -> w |> list_.map(int_.to_string) |> string_.join(" ")
    WordsFloat(w) -> w |> list_.map(float_.to_string) |> string_.join(" ")
    WordsString(w) -> w |> string_.join(" ")
    LinesInt(l) -> l |> list_.map(int_.to_string) |> string_.join("\n")
    LinesFloat(l) -> l |> list_.map(float_.to_string) |> string_.join("\n")
    LinesString(l) -> l |> string_.join(" ")
    MatrixInt(m) ->
      m
      |> list_.map(fn(w) { w |> list_.map(int_.to_string) |> string_.join(" ") })
      |> string_.join("\n")
    MatrixFloat(m) ->
      m
      |> list_.map(fn(w) {
        w |> list_.map(float_.to_string) |> string_.join(" ")
      })
      |> string_.join("\n")
    MatrixString(m) ->
      m
      |> list_.map(fn(w) { w |> string_.join(" ") })
      |> string_.join("\n")
  }
}

pub fn parse(lines: List(String), method: Parse) -> #(IOResult, List(String)) {
  let #(x, rest) = lines |> list_.split(1)
  let assert Ok(x) = list_.first(x)
  let assert Ok(res) = case method {
    ParseInt -> {
      use y <- result_.try(x |> string_.trim |> int_.parse)
      Ok(#(Int(y), rest))
    }
    ParseFloat -> {
      use y <- result_.try(x |> string_.trim |> float_.parse)
      Ok(#(Float(y), rest))
    }
    ParseString -> {
      Ok(#(String(x), rest))
    }
    ParseWords(method) -> {
      use y <- result_.try(x |> parse_words(method))
      Ok(#(y, rest))
    }
    ParseLines(count, method) -> {
      let #(lines, rest) = lines |> list_.split(count)
      use y <- result_.try(lines |> parse_lines(method))
      Ok(#(y, rest))
    }
  }
  res
}

fn parse_words(line: String, method: Parse) -> Result(IOResult, Nil) {
  let lst = line |> string_.trim |> string_.split(" ")
  case method {
    ParseInt -> {
      use y <- result_.try(lst |> list_.try_map(int_.parse))
      Ok(WordsInt(y))
    }
    ParseFloat -> {
      use y <- result_.try(lst |> list_.try_map(float_.parse))
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
      use y <- result_.try(lines |> list_.try_map(int_.parse))
      Ok(LinesInt(y))
    }
    ParseFloat -> {
      use y <- result_.try(lines |> list_.try_map(float_.parse))
      Ok(LinesFloat(y))
    }
    ParseString -> {
      Ok(LinesString(lines))
    }
    ParseWords(method) -> {
      case method {
        ParseInt -> {
          use y <- result_.try(
            lines
            |> list_.try_map(fn(line) {
              let lst = line |> string_.trim |> string_.split(" ")
              use y <- result_.try(lst |> list_.try_map(int_.parse))
              Ok(y)
            }),
          )
          Ok(MatrixInt(y))
        }
        ParseFloat -> {
          use y <- result_.try(
            lines
            |> list_.try_map(fn(line) {
              let lst = line |> string_.trim |> string_.split(" ")
              use y <- result_.try(lst |> list_.try_map(float_.parse))
              Ok(y)
            }),
          )
          Ok(MatrixFloat(y))
        }
        ParseString -> {
          let y =
            lines
            |> list_.map(fn(line) {
              let lst = line |> string_.trim |> string_.split(" ")
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
