defmodule ExampleWeb.PageController do
  use ExampleWeb, :controller

  def home(conn, _params), do: render(conn, :home)
  def svelte_1(conn, _params), do: render(conn, :svelte_1)
  def svelte_2(conn, _params), do: render(conn, :svelte_2)
  def svelte_3(conn, _params), do: render(conn, :svelte_3)
  def todo_list(conn, _params), do: render(conn, :todo_list)
  def animated_tasks(conn, _params), do: render(conn, :animated_tasks)
end
