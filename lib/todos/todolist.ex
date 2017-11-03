defmodule Todos.Todolist do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todolists" do
    field(:title, :string)
    has_many(:todo_items, Todos.TodoItems)
    belongs_to(:user, Todos.User)
    timestamps()
  end

  def changeset(record, params \\ :empty) do
    record
    |> cast(params, ~w(title))
    |> validate_required([:title])
  end
end
