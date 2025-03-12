# import Teller

defmodule Human do
  defstruct [:name]
end

defimpl Teller, for: Human do
  @spec say_something(any()) :: String.t()
  def say_something(_someone), do: "Hello, world!"
end
