defmodule Todos do
  import Ecto.Query
  alias Todos.Repo

  def add_item(todolist_id, text) do
    todolist = Repo.get(Todos.Todolist, todolist_id)
    text_item = %Todos.TodoItems{text: text}
    todo_list = Ecto.build_assoc(todolist, :todo_items, text_item)
    Repo.insert(todo_list)
  end

  def get_items(todolist_id) do
    query = from(ti in Todos.TodoItems, where: ti.todolist_id == ^todolist_id)
    result = Repo.all(query)
    Enum.flat_map(result, fn item -> [{item.id, item.text, item.completed}] end)
  end

  def mark_item_completed(item_id) do
    todo_item = Repo.get(Todos.TodoItems, item_id)
    Repo.update(Todos.TodoItems.changeset(todo_item, %{completed: true}))
  end

  def delete_item(item_id) do
    todo_item = Repo.get(Todos.TodoItems, item_id)
    Repo.delete(todo_item)
  end

  def add_tag_to_item(item_id, tag) do
    tag = Repo.insert!(%Todos.Tag{tag: tag})
    todo_item = Repo.get(Todos.TodoItems, item_id) |> Repo.preload(:tags)
    todo_item_changeset = Ecto.Changeset.change(todo_item)
    todo_item_with_tags = Ecto.Changeset.put_assoc(todo_item_changeset, :tags, [tag])
    Repo.update!(todo_item_with_tags)
  end

  def remove_tag_from_item(item_id, tag_id) do
    tag = Repo.get(Todos.Tag, tag_id)
    todo_item = Repo.get(Todos.TodoItems, item_id) |> Repo.preload(:tags)
    remaining_tags = Enum.reject(todo_item.tags, fn t -> t.tag == tag.tag end)
    todo_item_changeset = Ecto.Changeset.change(todo_item)
    todo_item_with_tags = Ecto.Changeset.put_assoc(todo_item_changeset, :tags, remaining_tags)
    Repo.update!(todo_item_with_tags)
  end
end
