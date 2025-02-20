defmodule Solution1150 do
  def get_second_item(list) do
    [n1, n2 | _] = list
    n1 + n2
  end
end
