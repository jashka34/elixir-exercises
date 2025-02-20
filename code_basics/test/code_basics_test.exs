defmodule CodeBasicsTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  import Solution0950
  doctest CodeBasics

  test "10/50 points and shapes" do
    point = {:point, 50, 50}
    assert Solution1050.is_point_inside_circle(point, {:circle, {:point, 10, 10}, 100})
    assert not Solution1050.is_point_inside_circle(point, {:circle, {:point, -10, -10}, 20})
    point = {:point, -10, 20}
    assert Solution1050.is_point_inside_rect(point, {:rect, {:point, -20, 30}, {:point, 20, 10}})
    assert not Solution1050.is_point_inside_rect(point, {:rect, {:point, 0, 0}, {:point, 10, 10}})
  end

  test "09/50 sigil_i" do
    assert 40 == ~i(40)
    assert -40 == ~i(40)n
  end

  test "08/50 hours_to_milliseconds" do
    assert 0 == Solution0850.hours_to_milliseconds(0)
    assert 3_600_000 == Solution0850.hours_to_milliseconds(1)
    assert 5_400_000.0 == Solution0850.hours_to_milliseconds(1.5)
    assert 7_200_000 == Solution0850.hours_to_milliseconds(2)
  end

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
