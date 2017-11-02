defmodule Todos.Todolist do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todolists" do
    field(:title, :string)

    timestamps()
  end

  @required_fields ~w(title)
  @optional_fields ~w()

  def changeset(record, params \\ :empty) do
    record
    |> cast(params, @required_fields, @optional_fields)
  end
end
