defmodule Todos.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:name, :string)
    field(:email, :string)

    has_many(:todolists, Todos.Todolist)
    timestamps()
  end

  def changeset(record, params \\ :empty) do
    record
    |> cast(params, ~w(name email))
    |> validate_required([:name, :email])
  end
end
