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

  # get "/todos" do
  #   todos = Todo.listar()
  #   todos_json = Jason.encode!(todos)
  #   send_resp(conn, 200, todos_json)
  # end
  get "/todos" do
    todos = Todo.listar()
    todos_json = Jason.encode!(todos)
    send_resp(conn, 200, todos_json)
  end

  post "/todos" do
    case Plug.Conn.read_body(conn) do
      {:ok, body, _conn} ->
        case Jason.decode(body) do
          {:ok, todo} ->
            Todo.anadir(conn, todo)
            send_resp(conn, 201, "Ok")

          {:error, _error} ->
            IO.puts(body)
            send_resp(conn, 400, "Invalid JSON payload")
        end

      {:error, _reason} ->
        send_resp(conn, 500, "Error reading request body")
    end
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end

defimpl Jason.Encoder, for: Todoapiex.Todo do
  def encode(%Todoapiex.Todo{titulo: _titulo, desc: _desc, completado: _completado} = todo, opts) do
    Map.from_struct(todo)
    |> Map.take([:titulo, :desc, :completado])
    |> Jason.Encode.map(opts)
  end
end
