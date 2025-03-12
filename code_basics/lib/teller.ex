defprotocol Teller do
  @spec say_something(any()) :: String.t()
  def say_something(someone)
end
