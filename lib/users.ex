defmodule Users do
  alias Todos.Repo

  def create_list(title) do
    Repo.insert(%Todos.Todolist{title: title})
  end

  def delete_list(list_id) do
    todolist = Repo.get(Todos.Todolist, list_id)
    Repo.delete(todolist)
  end

  def update_title(list_id, new_title) do
    todolist = Repo.get(Todos.Todolist, list_id)
    Repo.update(Todos.Todolist.changeset(todolist, %{title: new_title}))
  end
end
