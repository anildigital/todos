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

  test "As a user I should be able to add a text item to my user todolist", %{todolist: todolist} do
    # Given
    text_item = "Submit talk to conference"

    # When
    Todos.add_item(todolist.id, text_item)

    # Then
    items = Todos.get_items(todolist.id)
    [{item_id, text, completed}] = items
    assert [{item_id, "Submit talk to conference", false}] == items
  end

  test "As a user I should be able to mark my text item in todolist as complete", %{
    todolist: todolist
  } do
    # Given
    text_item = "Submit talk to conference"
    Todos.add_item(todolist.id, text_item)
    items = Todos.get_items(todolist.id)

    [{item_id, text, completed}] = items

    # When
    Todos.mark_item_completed(item_id)

    new_items = Todos.get_items(todolist.id)
    [{new_item_id, newtext, completed}] = new_items
    assert [{item_id, "Submit talk to conference", true}] == new_items
  end

  test "As a user I should be able to delete text item in a todolist", %{todolist: todolist} do
    # Given
    text_item = "Submit talk to conference"
    Todos.add_item(todolist.id, text_item)
    items = Todos.get_items(todolist.id)

    [{item_id, text, completed}] = items

    Todos.delete_item(item_id)

    new_items = Todos.get_items(todolist.id)

    assert [] == new_items
  end

  test "As a user I should be able to add tag to my text item in a todolist", %{
    todolist: todolist
  } do
    # Given
    text_item = "Submit talk to conference"
    {:ok, item} = Todos.add_item(todolist.id, text_item)

    # When
    tag = "cool"
    Todos.add_tag_to_item(item.id, tag)

    # Then
    items = Todos.get_items(todolist.id)
    [{item_id, text, completed}] = items
    item = Todos.Repo.get(Todos.TodoItems, item_id) |> Todos.Repo.preload(:tags)
    tag = Enum.at(item.tags, 0)
    assert "cool", tag.tag
  end

  test "As a user I should be able to remove tag from the text item from my todolist", %{
    todolist: todolist
  } do
    # Given
    text_item = "Submit talk to conference"
    {:ok, item} = Todos.add_item(todolist.id, text_item)
    tag = "cool"
    Todos.add_tag_to_item(item.id, tag)
    item = Todos.Repo.get(Todos.TodoItems, item.id) |> Todos.Repo.preload(:tags)

    IO.inspect(seee1: item.tags)
    items = Todos.get_items(todolist.id)

    tag_rec = Enum.at(item.tags, 0)

    # When
    Todos.remove_tag_from_item(item.id, tag_rec.id)
    item = Todos.Repo.get(Todos.TodoItems, item.id) |> Todos.Repo.preload(:tags)
    assert [] == item.tags
  end
end
