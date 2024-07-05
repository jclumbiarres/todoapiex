defmodule Todoapiex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Todoapiex.Worker.start_link(arg)
      # {Todoapiex.Worker, arg}
      {Plug.Cowboy, scheme: :http, plug: Todoapiex.Router, options: [port: 3000]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Todoapiex.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
