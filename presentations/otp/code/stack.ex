defmodule Stack do
  use GenServer

  def start_link(state) do
    {:ok, pid} = GenServer.start_link(Stack, state, [])
    pid
  end

  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  def push(pid, value) do
    GenServer.cast(pid, {:push, value})
  end

  def handle_call(:pop, _from, []) do
    {:reply, nil, []}
  end

  def handle_call(:pop, _from, state) do
    [head|new_state] = state

    {:reply, head, new_state}
  end

  def handle_cast({:push, value}, state) do
    {:noreply, [value|state]}
  end
end
