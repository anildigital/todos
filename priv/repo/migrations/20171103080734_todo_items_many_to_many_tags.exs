defmodule Todos.Repo.Migrations.TodoItemsManyToManyTags do
  use Ecto.Migration

  def change do
    create table(:todo_items_tags) do
      add(:todo_items_id, references(:todo_items))
      add(:tag_id, references(:tags))
    end

    create(unique_index(:todo_items_tags, [:todo_items_id, :tag_id]))
  end
end
