defmodule Dog do
  defstruct [:name]
end

defimpl Teller, for: Dog do
  @spec say_something(any()) :: String.t()
  def say_something(_someone), do: "Bark, world!"
end
