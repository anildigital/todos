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
    Enum.flat_map(result, fn item -> [{item.text, item.completed}] end)
  end
end
