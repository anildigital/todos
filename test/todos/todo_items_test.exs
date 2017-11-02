defmodule Todos.TodoItemsTest do
  alias TodoItems
  use ExUnit.Case

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Todos.Repo)
  end

  test "adding and retrieving todo items" do
    assert [] == TodoItems.items()

    TodoItems.add("Make example app")
    TodoItems.add("Write blog post")

    assert [{"Make example app", false}, {"Write blog post", false}] == TodoItems.items()
  end
end
