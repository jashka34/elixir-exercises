defmodule ProcessRegister do
  use Agent

  def start_link(init_state \\ %{}) do
    Agent.start_link(fn -> init_state end, name: __MODULE__)
  end

  def list_registered do
    children = Agent.get(__MODULE__, fn state -> state end)
    # dbg(children)
    children
  end

  def add(pid, pn) do
    already_registered = Map.has_key?(list_registered(), pn)

    if !already_registered && Process.alive?(pid) do
      Process.register(pid, pn)
      Agent.update(__MODULE__, fn state -> Map.put(state, pn, pid) end)
    end

    :ok
  end

  def drop(pn) do
    try do
      Process.unregister(pn)
      :ok
    rescue
      _ -> :ok
    after
      Agent.update(__MODULE__, fn state -> Map.delete(state, pn) end)
    end
  end
end
