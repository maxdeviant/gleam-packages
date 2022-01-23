import gleam/bit_builder.{BitBuilder}
import gleam/http.{Request, Response}
import gleam/http/elli
import gleam/erlang
import gleam/string
import gleam/int
import gleam/io

pub fn my_service(_req: Request(BitString)) -> Response(BitBuilder) {
  let body = bit_builder.from_string("Hello, Joe!")

  http.response(200)
  |> http.prepend_resp_header("made-with", "Gleam")
  |> http.set_resp_body(body)
}

pub fn main() {
  let port = 3000

  // Start the web server process
  assert Ok(_) = elli.start(my_service, on_port: port)

  io.println(string.concat([
    "Started listening on localhost:",
    int.to_string(port),
    " ✨",
  ]))

  // Put the main process to sleep while the web server does its thing
  erlang.sleep_forever()
}
