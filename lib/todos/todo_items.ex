[defmodule Todos.TodoItems do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todo_items" do
    field(:text, :string)
    field(:completed, :boolean, default: false)

    belongs_to(:todolist, Todos.Todolist)
    many_to_many(:tags, Todos.Tag, join_through: "todo_items_tags", on_replace: :delete)
    timestamps()
  end

  def changeset(record, params \\ :empty) do
    record
    |> cast(params, ~w(text completed))
    |> validate_required([:text])
  end
end
