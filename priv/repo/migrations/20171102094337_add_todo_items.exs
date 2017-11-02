defmodule Todos.Repo.Migrations.AddTodoItems do
  use Ecto.Migration

  def change do
    create table(:todo_items) do
      add(:text, :string)
      add(:completed, :boolean, default: false)
      timestamps()
    end
  end
end
