defmodule Todos.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:name, :string)
    field(:email, :string)

    has_many(:todolists, Todos.Todolist)
    timestamps()
  end

  @required_fields ~w(name email)
  @optional_fields ~w()

  def changeset(record, params \\ :empty) do
    record
    |> cast(params, @required_fields, @optional_fields)
  end
end
