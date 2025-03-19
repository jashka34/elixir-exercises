defmodule Accumulator do
  def start_link(initial_state) do
    Agent.start_link(fn -> initial_state end, name: __MODULE__)
  end

  def current do
    Agent.get(__MODULE__, fn state -> state end)
  end

  def add(n) do
    Agent.update(__MODULE__, fn state ->
      Calculator.exec(:+, state, n)
    end)
  end

  def mul(n) do
    Agent.update(__MODULE__, fn state ->
      Calculator.exec(:*, state, n)
    end)
  end

  def sub(n) do
    Agent.update(__MODULE__, fn state ->
      Calculator.exec(:-, state, n)
    end)
  end

  def div(n) do
    Agent.update(__MODULE__, fn state ->
      Calculator.exec(:/, state, n)
    end)
  end

  def reset do
    Agent.update(__MODULE__, fn _ -> 0 end)
  end
end
