defmodule Cat do
  defstruct [:name]
end

defimpl Teller, for: Cat do
  @spec say_something(any()) :: String.t()
  def say_something(_someone), do: "Meow, world!"
end
