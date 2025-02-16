defmodule CodeBasicsTest do
  use ExUnit.Case
  doctest CodeBasics

  test "05/50 do math " do
    res = Solution0550.do_math(1, 2)
    assert 1 == 2
  end

  test "04/50 join and upcase works" do
    res = Solution0450.join_and_upcase(" привет ", "world!")
    assert res == "привет WORLD!"

    res = Solution0450.join_and_upcase("hello ", "мир!  ")
    assert res == "HELLO мир!"

    res = Solution0450.join_and_upcase("   hello ", "world!  ")
    assert res == "HELLO WORLD!"
  end
end
