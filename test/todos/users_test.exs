defmodule Todos.UsersTest do
  alias Todos.Repo
  alias TodoItems
  use ExUnit.Case

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Todos.Repo)
  end

  test "as a user I should be able to create a todolist" do
    # Given
    todolist_title = "My daily todolist"

    # When
    {:ok, todolist} = Users.create_list(todolist_title)

    # Then
    assert todolist_title, todolist.title
  end

  test "As a user I should be able to delete the list" do
    # Given
    todolist_title = "My daily todolist"
    {:ok, todolist} = Users.create_list(todolist_title)

    ## When
    Users.delete_list(todolist.id)

    ## Then
    todolist = Repo.get(Todos.Todolist, todolist.id)
    assert nil == todolist
  end
end
