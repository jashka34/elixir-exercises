defmodule Worker do
  def work(number) do
    cond do
      rem(number, 3) == 0 && rem(number, 5) == 0 -> exit(:foobar)
      rem(number, 3) == 0 -> exit(:foo)
      rem(number, 5) == 0 -> exit(:bar)
      true -> exit(:normal)
    end
  end
end
