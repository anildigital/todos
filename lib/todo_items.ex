defmodule TodoItems do
  alias Todos.TodoItems
  alias Todos.Repo

  def items do
    result = Repo.all(TodoItems)
    Enum.flat_map(result, fn item -> [{item.text, item.completed}] end)
  end

  def add(text) do
    # changeset = TodoItems.changeset(%Todos.TodoItems{}, %{text: text}) #
    Repo.insert(%Todos.TodoItems{text: text})
  end
end
