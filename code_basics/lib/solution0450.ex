defmodule Solution0450 do
  def join_and_upcase(s1, s2) do
    String.trim(String.upcase(s1, :ascii)) <> " " <> String.trim(String.upcase(s2, :ascii))
  end
end
