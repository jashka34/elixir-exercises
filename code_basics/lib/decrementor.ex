defmodule Decrementor do
  use Agent

  def start_link(initial_state \\ 0) do
    Agent.start_link(fn -> initial_state end, name: __MODULE__)
  end

  def current_value, do: Agent.get(__MODULE__, fn state -> state end)
  def run, do: Agent.update(__MODULE__, fn state -> state - 1 end)
end
