import Config

config :todoapiex,
  ecto_repos: [Todoapiex.Repo]

config :todoapiex, Todoapiex.Repo,
  database: Path.expand("../todolistex_#{Mix.env()}.db", Path.dirname(__ENV__.file)),
  pool_size: 5
