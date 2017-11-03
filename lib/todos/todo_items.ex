defmodule Todos.TodoItems do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todo_items" do
    field(:text, :string)
    field(:completed, :boolean, default: false)

    belongs_to(:todolist, Todos.Todolist)
    timestamps()
  end

  @required_fields ~w(text)
  @optional_fields ~w()

  def changeset(record, params \\ :empty) do
    record
    |> cast(params, @required_fields, @optional_fields)
  end
end
