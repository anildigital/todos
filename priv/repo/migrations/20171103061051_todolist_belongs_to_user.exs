defmodule Todos.Repo.Migrations.TodolistBelongsToUser do
  use Ecto.Migration

  def change do
    alter table(:todolists) do
      add(:user_id, references(:users))
    end
  end
end
