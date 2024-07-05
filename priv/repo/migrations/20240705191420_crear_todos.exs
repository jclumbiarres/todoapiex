defmodule DataCollector.Repo.Migrations.CrearTodos do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add(:titulo, :string)
      add(:desc, :string)
      add(:completado, :boolean)
      timestamps()
    end
  end
end
