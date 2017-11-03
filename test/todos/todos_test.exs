defmodule TodosTest do
  use ExUnit.Case
  alias Todos.Todolist
  doctest Todos

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Todos.Repo)
    todolist_title = "My daily todolist"
    {:ok, todolist} = Users.create_list(todolist_title)
    {:ok, todolist: todolist}
  end

  test "As a user I should be able to add a text item to my todolist", %{todolist: todolist} do
    # Given
    text_item = "Submit talk to conference"

    # When
    Todos.add_item(todolist.id, text_item)

    # Then
    items = Todos.get_items(todolist.id)
    assert [{"Submit talk to conference", false}] == items
  end
end
