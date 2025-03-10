defmodule CodeBasicsTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  import Solution
  import Pet
  import User

  # 29/50
  describe "29/50 generate_pets work" do
    test "with valid input" do
      pets = Solution.generate_pets(3)

      assert is_list(pets)

      Enum.each(Enum.with_index(pets), fn {pet, index} ->
        assert is_struct(pet, Pet)
        assert pet.name == "Barkley #{index}"
      end)
    end

    test "with invalid input" do
      pets = Solution.generate_pets(-20)

      assert is_list(pets)
      assert Enum.empty?(pets)
    end
  end

  # 28/50
  test "28/50 structs" do
    assert calculate_stats([]) == %{humans: 0, pets: 0}
    assert calculate_stats([%User{}, %User{}, %Pet{}]) == %{humans: 2, pets: 1}
    assert calculate_stats([%Pet{}, %Pet{}, %Pet{}]) == %{humans: 0, pets: 3}
  end

  # 27/50
  test "27/50 stream" do
    g5 = generate(5)
    g15 = generate(15)
    g30 = generate(30)

    assert check_random(g5, 5)
    assert check_random(g15, 15)
    assert check_random(g30, 30)
  end

  defp check_random(list, count) do
    count_ok = count == length(list)

    all_elem_is_number_and_in_range =
      list
      |> Enum.map(fn x -> is_number(x) and x in 1..20 end)
      |> Enum.all?()

    count_ok and all_elem_is_number_and_in_range
  end

  # 26/50
  test "26/50 comprehensions" do
    employees = [
      %{
        name: "Eric",
        status: :active,
        hobbies: [%{name: "Text Adventures", type: :gaming}, %{name: "Chickens", type: :animals}]
      },
      %{
        name: "Mitch",
        status: :former,
        hobbies: [%{name: "Woodworking", type: :making}, %{name: "Homebrewing", type: :making}]
      },
      %{
        name: "Greg",
        status: :active,
        hobbies: [
          %{name: "Dungeons & Dragons", type: :gaming},
          %{name: "Woodworking", type: :making}
        ]
      }
    ]

    assert fetch_gamers(employees) ==
             [
               {"Eric", %{name: "Text Adventures", type: :gaming}},
               {"Greg", %{name: "Dungeons & Dragons", type: :gaming}}
             ]
  end

  # 25/50
  test "25/50 reduce" do
    assert max_delta([], []) == 0
    assert max_delta([10, -15, 35], [2, -12, 42]) == 8
    assert max_delta([-5], [-15]) == 10
  end

  # 24/50
  test "24/50 filter" do
    assert inc_numbers([]) == []
    assert inc_numbers(["foo", false, ["foo"]]) == []
    assert inc_numbers([10, "foo", false, true, ["foo"], 1.2, %{}, 32]) == [11, 2.2, 33]
    assert inc_numbers([1, 2, 3, 4, 5, 6.0]) == [2, 3, 4, 5, 6, 7.0]
  end

  # 23/50
  test "23/50 map" do
    assert zip([], []) == []
    assert zip([1, 2, 3, 4], [5, 6, 7, 8]) == [[1, 5], [2, 6], [3, 7], [4, 8]]
    assert zip([1, 2], [3, 4]) == [[1, 3], [2, 4]]
    assert zip([1, 2], [3]) == [[1, 3], [2, nil]]
    assert zip([1], [3, 4]) == [[1, 3], [nil, 4]]
    assert zip([], [3, 4]) == [[nil, 3], [nil, 4]]
  end

  # 22/50
  test "21/50 anonym func" do
    assert calculate("+", 2, 3) == 5
    assert calculate("+", 0, -3) == -3
    assert calculate("-", 2, 3) == -1
    assert calculate("-", 0, 3) == -3
    assert calculate("/", 4, 4) == 1.0
    assert calculate("/", 3, 2) == 1.5
    assert calculate("*", 2, 2) == 4
    assert calculate("*", 0, 2) == 0
  end

  # 21/50
  test "20/50 immut struct" do
    assert encode(~c"Hello", 10) == ~c"Rovvy"
    assert encode(~c"Hello", 5) == ~c"Mjqqt"
    assert decode(~c"Rovvy", 10) == ~c"Hello"
    assert decode(~c"Mjqqt", 5) == ~c"Hello"
  end

  # 20/50
  test "20/50 recur and accums" do
    users = [
      {:user, 1, "Bob", 23},
      {:user, 2, "Helen", 20},
      {:user, 3, "Bill", 15},
      {:user, 4, "Kate", 14}
    ]

    assert filter_by_age(users, 16) == [{:user, 1, "Bob", 23}, {:user, 2, "Helen", 20}]

    assert filter_by_age(users, 14) == [
             {:user, 1, "Bob", 23},
             {:user, 2, "Helen", 20},
             {:user, 3, "Bill", 15}
           ]

    assert filter_by_age(users, 22) == [
             {:user, 1, "Bob", 23}
           ]
  end

  # 19/50
  test "19/50 range" do
    assert [1, 2, 3, 4, 5] == range(1, 5)
    assert [2] == range(2, 2)
    assert [] == range(3, 2)
  end

  # 18/50
  test "18/50 my cool string" do
    assert "my cool strmy cool str" = my_cool_string(" mY COOl Str    ", 2)
    assert "" = my_cool_string("    ", 2)
  end

  # 17/50
  test "17/50 valid_game? positive test" do
    assert valid_game?({{:x, :x, :x}, {:x, :x, :x}, {:x, :x, :x}})
    assert valid_game?({{:o, :o, :o}, {:o, :o, :o}, {:o, :o, :o}})
    assert valid_game?({{:f, :f, :f}, {:f, :f, :f}, {:f, :f, :f}})
    assert valid_game?({{:x, :o, :f}, {:f, :x, :o}, {:o, :o, :x}})
  end

  test "17/50 valid_game? negative test" do
    assert not valid_game?({{:x, :o, :some}, {:f, :x, :o}, {:o, :o, :x}})
    assert not valid_game?({{:x, :x, :x}, {:x, :some, :x}, {:x, :x, :x}})
    assert not valid_game?({{:o, :o, :o}, {:o, :o, :o}, {:o, :o, :some}})

    assert not valid_game?({{:x, :o, :f}, {:f, :x, :o}, {:o, :o, :x, :x}})
    assert not valid_game?({{:x, :o, :f}, {:f, :x, :x, :o}, {:o, :o, :x}})
    assert not valid_game?({{:x, :o, :x, :f}, {:f, :x, :o}, {:o, :o, :x}})

    assert not valid_game?({{:x, :o, :f}, {:f, :x, :o}, {:o, :o}})
    assert not valid_game?({{:x, :o, :f}, {:f, :o}, {:o, :o, :x}})
    assert not valid_game?({{:x, :o}, {:f, :x, :o}, {:o, :o, :x}})

    assert not valid_game?({{:x, :o, :f}, {:f, :x, :o}, {:o, :o, :x}, {:x, :x, :x}})
    assert not valid_game?({{:x, :o, :f}, {:f, :x, :o}})
  end

  test "17/50 check_who_win test" do
    assert {:win, :x} == check_who_win({{:x, :x, :x}, {:f, :f, :o}, {:f, :f, :o}})
    assert {:win, :o} == check_who_win({{:f, :x, :f}, {:o, :o, :o}, {:x, :f, :f}})
    assert {:win, :x} == check_who_win({{:f, :o, :f}, {:o, :f, :f}, {:x, :x, :x}})

    assert {:win, :o} == check_who_win({{:o, :x, :f}, {:o, :f, :x}, {:o, :f, :f}})
    assert {:win, :x} == check_who_win({{:f, :x, :o}, {:p, :x, :f}, {:f, :x, :f}})
    assert {:win, :o} == check_who_win({{:f, :x, :o}, {:f, :x, :o}, {:f, :f, :o}})

    assert {:win, :x} == check_who_win({{:x, :f, :o}, {:o, :x, :f}, {:f, :f, :x}})
    assert {:win, :o} == check_who_win({{:f, :f, :o}, {:x, :o, :f}, {:o, :x, :f}})

    assert :no_win == check_who_win({{:x, :f, :f}, {:f, :x, :x}, {:f, :f, :o}})
    assert :no_win == check_who_win({{:x, :o, :o}, {:o, :x, :x}, {:x, :o, :o}})
  end

  # 16/50
  test "16/50 single_win? test" do
    assert single_win?(true, false)
    assert single_win?(false, true)
    assert not single_win?(true, true)
    assert not single_win?(false, false)
  end

  test "16/50 double_win? test" do
    assert :ab == double_win?(true, true, false)
    assert :bc == double_win?(false, true, true)
    assert :ac == double_win?(true, false, true)
    assert not double_win?(true, true, true)
    assert not double_win?(false, false, false)
    assert not double_win?(true, false, false)
    assert not double_win?(false, true, false)
    assert not double_win?(false, false, true)
  end

  # 15/50
  test "15/50 join_game test" do
    assert :ok == join_game({:user, "Bob", 17, :admin})
    assert :ok == join_game({:user, "Bob", 27, :admin})
    assert :ok == join_game({:user, "Bob", 17, :moderator})
    assert :ok == join_game({:user, "Bob", 27, :moderator})
    assert :error == join_game({:user, "Bob", 17, :member})
    assert :ok == join_game({:user, "Bob", 27, :member})
  end

  test "15/50 move_allowed? test" do
    assert move_allowed?(:white, {:pawn, :white})
    assert not move_allowed?(:black, {:pawn, :white})
    assert move_allowed?(:white, {:rock, :white})
    assert not move_allowed?(:black, {:rock, :white})
    assert not move_allowed?(:white, {:queen, :white})
    assert not move_allowed?(:black, {:queen, :white})
  end

  # 14/50
  test "14/50 pattern matching dictionaries" do
    assert {1, 2} = get_values(%{a: 1, b: 2})
    assert {:ok, 42} = get_values(%{a: :ok, b: 42, c: true})

    assert_raise MatchError, fn ->
      get_values(%{})
    end

    assert 42 = get_value_by_key(%{answer: 42}, :answer)
    assert "6 * 7" = get_value_by_key(%{question: "6 * 7"}, :question)

    assert_raise MatchError, fn ->
      get_value_by_key(%{a: 1}, :b)
    end
  end

  test "13/50 pattern matching maps" do
    bob = {:user, "Bob", 42}
    helen = {:user, "Helen", 20}
    kate = {:user, "Kate", 22}
    assert 42 == get_age(bob)
    assert 20 == get_age(helen)
    assert 22 == get_age(kate)
    assert ["Bob", "Helen", "Kate"] == get_names([bob, helen, kate])
  end

  test "12/50 maps" do
    map = %{a: 1, b: 2, c: 42}
    assert keys_sum(map, :a, :b) == 3
    assert keys_sum(map, :a, :c) == 43
    assert keys_sum(map, :c, :b) == 44
    assert keys_sum(map, :a, :d) == 1

    map = %{one: 1, five: 5, ten: 10}
    assert keys_product(map, :one, :five) == 5
    assert keys_product(map, :five, :ten) == 50
    assert keys_product(map, :two, :ten) == 10

    map1 = %{a: 1, b: 2}
    map2 = %{c: 3, d: 4}

    assert copy_key(map1, map2, :a, 42) == %{c: 3, d: 4, a: 1}
    assert copy_key(map1, map2, :b, 42) == %{c: 3, d: 4, b: 2}

    assert copy_key(map2, map1, :d, 42) == %{a: 1, b: 2, d: 4}
    assert copy_key(map2, map1, :e, 42) == %{a: 1, b: 2, e: 42}
  end

  test "11/50 lists" do
    assert 42 == get_second_item([20, 22, 24])
    assert 3 == get_second_item([1, 2, 3, 4])
  end

  test "10/50 points and shapes" do
    point = {:point, 50, 50}
    assert is_point_inside_circle(point, {:circle, {:point, 10, 10}, 100})
    assert not is_point_inside_circle(point, {:circle, {:point, -10, -10}, 20})
    point = {:point, -10, 20}
    assert is_point_inside_rect(point, {:rect, {:point, -20, 30}, {:point, 20, 10}})
    assert not is_point_inside_rect(point, {:rect, {:point, 0, 0}, {:point, 10, 10}})
  end

  test "09/50 sigil_i" do
    assert 40 == ~i(40)
    assert -40 == ~i(40)n
  end

  test "08/50 hours_to_milliseconds" do
    assert 0 == hours_to_milliseconds(0)
    assert 3_600_000 == hours_to_milliseconds(1)
    assert 5_400_000.0 == hours_to_milliseconds(1.5)
    assert 7_200_000 == hours_to_milliseconds(2)
  end

  test "06/50 any?" do
    assert false == any?(false, false, false, false)
    assert true == any?(true, false, false, false)
    assert true == any?(false, true, false, false)
    assert true == any?(false, false, true, false)
    assert true == any?(false, false, false, true)
    assert true == any?(false, true, false, true)
  end

  test "06/50 truthy?" do
    assert 42 == truthy?(true, 42)
    assert [42] == truthy?(1, [42])
    assert false == truthy?("hello", false)
    assert nil == truthy?("", nil)
  end

  test "05/50 do math" do
    # IO.puts(capture_io(fn -> do_math(10, 10) end))
    assert "2.0\n1\n0\n" == capture_io(fn -> do_math(10, 10) end)
    assert "4.0\n3\n5\n" == capture_io(fn -> do_math(15, 5) end)
    assert "15.0\n14\n3\n" == capture_io(fn -> do_math(42, 3) end)
  end

  test "04/50 join and upcase works" do
    res = join_and_upcase(" привет ", "world!")
    assert res == "привет WORLD!"

    res = join_and_upcase("hello ", "мир!  ")
    assert res == "HELLO мир!"

    res = join_and_upcase("   hello ", "world!  ")
    assert res == "HELLO WORLD!"
  end
end
