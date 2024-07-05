defmodule Todoapiex.Router do
  alias Todoapiex.{Todo}
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  get "/todos" do
    todos = Todo.listar()
    todos_json = Jason.encode!(todos)
    send_resp(conn, 200, todos_json)
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
