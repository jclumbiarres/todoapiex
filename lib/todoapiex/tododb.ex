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
end
