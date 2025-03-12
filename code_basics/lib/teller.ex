defprotocol Teller do
  @fallback_to_any true
  @spec say_something(any()) :: String.t()
  def say_something(someone)
end

defmodule Cat do
  defstruct [:name]
end

defimpl Teller, for: Cat do
  @spec say_something(any()) :: String.t()
  def say_something(_someone), do: "Meow, world!"
end

defmodule Dog do
  defstruct [:name]
end

defimpl Teller, for: Dog do
  @spec say_something(any()) :: String.t()
  def say_something(_someone), do: "Bark, world!"
end

defmodule Human do
  defstruct [:name]
end

defimpl Teller, for: Human do
  @spec say_something(any()) :: String.t()
  def say_something(_someone), do: "Hello, world!"
end

defmodule Robot do
  defstruct [:name]
end

defimpl Teller, for: Any do
  @spec say_something(any()) :: String.t()
  def say_something(_someone), do: "World!"
end
