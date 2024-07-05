defmodule Todoapiex.Todo do
  use Ecto.Schema
  import Ecto.Changeset
  alias Todoapiex.Todo

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
      %Todoapiex.Todo{}
      |> changeset(params)
      |> Todoapiex.Repo.insert()
  end

  def completar(todo) do
    %Todoapiex.Todo{todo | completado: true}
  end

  def listar do
    Todoapiex.Repo.all(Todo)
  end

  def listarId(id) do
    {:ok, _} =
      Todo
      |> Todoapiex.Repo.get(id)
  end

  def borrarId(id) do
    case Todoapiex.Repo.get(Todo, id) do
      nil -> {:error, "No existe"}
      todo -> Todoapiex.Repo.delete(todo)
    end
  end

  def borrarTodo do
    Todoapiex.Repo.delete_all(Todo)
  end
end
