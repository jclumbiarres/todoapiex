defmodule DataCollector.Repo do
  use Ecto.Repo, otp_app: :todolistex, adapter: Ecto.Adapters.SQLite3
end

defmodule DataCollector.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field(:titulo, :string)
    field(:desc, :string)
    field(:completado, :boolean)

    timestamps()
  end

  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:titulo, :desc, :completado])
    |> validate_required([:titulo, :desc, :completado])
  end

  # Funciones de consulta y demás
  def anadir(_, params) do
    {:ok, _} =
      %DataCollector.Todo{}
      |> DataCollector.Todo.changeset(params)
      |> DataCollector.Repo.insert()
  end

  def completar(todo) do
    %DataCollector.Todo{todo | completado: true}
  end

  def listar do
    {:ok, _} =
      Todo
      |> DataCollector.Repo.all()
  end

  def listarId(id) do
    {:ok, _} =
      Todo
      |> DataCollector.Repo.get(id)
  end

  def borrarId(id) do
    case DataCollector.Repo.get(Todo, id) do
      nil -> {:error, "No existe"}
      todo -> DataCollector.Repo.delete(todo)
    end
  end

  def borrarTodo do
    DataCollector.Repo.delete_all(Todo)
  end
end
