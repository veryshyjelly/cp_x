// @head begin
import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode.{type Decoder}
import gleam/option.{type Option}
import gleam/result

// @head end

// @code begin
@external(erlang, "erlang", "put")
fn do_put(key: a, value: b) -> Dynamic

@external(erlang, "erlang", "get")
fn do_get(key: a) -> Dynamic

pub fn put(key: a, value: b) -> Nil {
  do_put(key, value)
  Nil
}

pub fn get(key: k, decoder: Decoder(v)) -> Option(v) {
  do_get(key)
  |> decode.run(decode.optional(decoder))
  |> result.unwrap(option.None)
}
// @code end
