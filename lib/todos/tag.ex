defmodule Todos.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tags" do
    field(:tag, :string)
    has_many(:todolists, Todos.Todolist)
    many_to_many(:todo_items, Todos.TodoItems, join_through: "todo_items_tags")
    timestamps()
  end

  def changeset(record, params \\ :empty) do
    record
    |> cast(params, ~w(tag))
    |> validate_required([:tag])
  end
end
