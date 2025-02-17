defmodule CodeBasicsTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest CodeBasics

  test "06/50 any?" do
    assert false == Solution0650.any?(false, false, false, false)
    assert true == Solution0650.any?(true, false, false, false)
    assert true == Solution0650.any?(false, true, false, false)
    assert true == Solution0650.any?(false, false, true, false)
    assert true == Solution0650.any?(false, false, false, true)
    assert true == Solution0650.any?(false, true, false, true)
  end

  test "06/50 truthy?" do
    assert 42 == Solution0650.truthy?(true, 42)
    assert [42] == Solution0650.truthy?(1, [42])
    assert false == Solution0650.truthy?("hello", false)
    assert nil == Solution0650.truthy?("", nil)
  end

  test "05/50 do math" do
    # IO.puts(capture_io(fn -> Solution0550.do_math(10, 10) end))
    assert "2.0\n1\n0\n" == capture_io(fn -> Solution0550.do_math(10, 10) end)
    assert "4.0\n3\n5\n" == capture_io(fn -> Solution0550.do_math(15, 5) end)
    assert "15.0\n14\n3\n" == capture_io(fn -> Solution0550.do_math(42, 3) end)
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
