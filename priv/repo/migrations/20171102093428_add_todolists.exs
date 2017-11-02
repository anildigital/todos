defmodule Todos.Repo.Migrations.AddTodolists do
  use Ecto.Migration

  def change do
    create table(:todolists) do
      add(:title, :string)
      timestamps()
    end
  end
end
