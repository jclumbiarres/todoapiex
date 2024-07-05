defmodule Todoapiex.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  get "/todos" do
    send_resp(conn, 200, Jason.encode!(%{todos: []}))
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
