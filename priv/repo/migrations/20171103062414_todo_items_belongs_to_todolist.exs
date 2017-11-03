defmodule Todos.Repo.Migrations.TodoItemsBelongsToTodolist do
  use Ecto.Migration

  def change do
    alter table(:todo_items) do
      add(:todolist_id, references(:todolists))
    end
  end
end
