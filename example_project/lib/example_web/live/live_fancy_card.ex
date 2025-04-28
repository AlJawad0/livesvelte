defmodule ExampleWeb.LiveFancyCard do
  use ExampleWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="flex flex-col items-center py-8">
      <h1 class="text-2xl font-bold mb-4">High-Fidelity Svelte FancyCard Example</h1>
      <.svelte name="FancyCardModalDemo" />
    </div>
    """
  end

  def mount(_session, _params, socket) do
    {:ok, socket}
  end
end
