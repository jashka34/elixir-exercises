defmodule Calculator do
  def exec(:+, x, y), do: x + y
  def exec(:-, x, y), do: x - y
  def exec(:*, x, y), do: x * y
  def exec(:/, x, y), do: div(x, y)
end
