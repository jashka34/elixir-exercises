defmodule CodeBasicsTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  import Solution

  defmodule Exercise do
    require Solution

    Solution.prohibit_words(["hello", "world", "foo"])

    def run_fn(function) do
      Solution.with_logging do
        function
      end
    end
  end

  describe "49/50 datetimes" do
    test "with Date" do
      time = Date.utc_today()

      assert Date.add(time, -2) == Solution.shift_days(time, -2)
      assert Date.add(time, 2) == Solution.shift_days(time, 2)
      assert Date.add(time, 1) == Solution.shift_days(time, 1)
      assert Date.add(time, 0) == Solution.shift_days(time, 0)
    end

    test "with NaiveDateTime" do
      time = NaiveDateTime.utc_now()

      assert NaiveDateTime.add(time, days_to_seconds(-2), :second) ==
               Solution.shift_days(time, -2)

      assert NaiveDateTime.add(time, days_to_seconds(2), :second) == Solution.shift_days(time, 2)
      assert NaiveDateTime.add(time, days_to_seconds(1), :second) == Solution.shift_days(time, 1)
      assert NaiveDateTime.add(time, 0, :second) == Solution.shift_days(time, 0)
    end

    test "with DateTime" do
      time = DateTime.utc_now()

      assert DateTime.add(time, days_to_seconds(-2), :second) == Solution.shift_days(time, -2)
      assert DateTime.add(time, days_to_seconds(2), :second) == Solution.shift_days(time, 2)
      assert DateTime.add(time, days_to_seconds(1), :second) == Solution.shift_days(time, 1)
      assert DateTime.add(time, 0, :second) == Solution.shift_days(time, 0)
    end

    test "with Time" do
      time = Time.utc_now()

      assert Time.add(time, days_to_seconds(-2), :second) == Solution.shift_days(time, -2)
      assert Time.add(time, days_to_seconds(2), :second) == Solution.shift_days(time, 2)
      assert Time.add(time, days_to_seconds(1), :second) == Solution.shift_days(time, 1)
      assert Time.add(time, 0, :second) == Solution.shift_days(time, 0)
    end

    defp days_to_seconds(amount) do
      amount * 24 * 60 * 60
    end
  end

  describe "48/50 module stats" do
    test "when no function defined" do
      new_module = """
        defmacro MyModule do
          require Integer

          @some_attr "1"

          defmacro no_interference do
            quote do: a = 1
          end
        end
      """

      assert Solution.collect_module_stats(new_module) == []
    end

    test "when few functions defined" do
      new_module = """
        defmacro MyModule do
          def hello() do
            "world"
          end

          def test(a, b) do
            a + b
          end
        end
      """

      assert Solution.collect_module_stats(new_module) == [
               %{arity: 2, name: :test},
               %{arity: 0, name: :hello}
             ]
    end

    test "when few functions and protocols defined" do
      new_module = """
        defmacro MyModule do
          def hello(string) do
            [string, "world"]
          end

          def magic(a, b, c) do
            (a + b) * c
          end

          defp test(a, b) do
            a + b
          end
        end
      """

      assert Solution.collect_module_stats(new_module) == [
               %{arity: 2, name: :test},
               %{arity: 3, name: :magic},
               %{arity: 1, name: :hello}
             ]
    end
  end

  test "47/50 macros logging" do
    assert capture_io(fn -> Exercise.run_fn(fn -> 1 + 5 end) end) ==
             "Started execution...\nExecution result is: 6\n"

    assert capture_io(fn -> Exercise.run_fn(fn -> %{hello: :world} end) end) ==
             "Started execution...\nExecution result is: %{hello: :world}\n"

    assert capture_io(fn ->
             Exercise.run_fn(fn -> "some string" end)
           end) == "Started execution...\nExecution result is: \"some string\"\n"
  end

  test "46/50 prohibit_words" do
    assert Exercise.forbidden?("hello")
    assert Exercise.forbidden?("world")
    assert Exercise.forbidden?("foo")
    refute Exercise.forbidden?("baz")
    refute Exercise.forbidden?(2)
    refute Exercise.forbidden?(%{hello: :world})
  end

  test "45/50 unless" do
    assert my_unless(false, do: 1 + 3) == 4
    refute my_unless(true, do: 2)
    refute my_unless(2 == 2, do: "Hello")
    assert my_unless(1 == 2, do: "world") == "world"
  end

  test "44/50 my_abs macro work" do
    assert my_abs(2) == 2
    assert my_abs(abs(-3)) == 3
    assert my_abs(-2) == 2
    assert my_abs(-5 * 100) == 500
    assert my_abs(-2 - 100 + 1) == 101
  end

  describe "43/50 solution genserver work" do
    test "initialization work" do
      {:ok, pid} = Solution4350.start_link()

      assert Process.alive?(pid)
      Process.exit(pid, :normal)
    end

    test "current_state work" do
      {:ok, pid} = Solution4350.start_link(%{test: "value"})

      assert Solution4350.current_state() == %{test: "value"}
      Process.exit(pid, :normal)
    end

    test "reset work" do
      {:ok, pid} = Solution4350.start_link(%{test: "value"})

      assert Solution4350.reset() == :ok
      assert Solution4350.current_state() == %{}
      Process.exit(pid, :normal)
    end

    test "has? work" do
      {:ok, pid} = Solution4350.start_link(%{test: "value"})

      assert Solution4350.has?(:test)
      refute Solution4350.has?(:some)
      Process.exit(pid, :normal)
    end

    test "add work" do
      {:ok, pid} = Solution4350.start_link(%{test: "value"})

      assert Solution4350.add(:some, 2) == :ok
      assert Solution4350.current_state() == %{test: "value", some: 2}
      Process.exit(pid, :normal)
    end

    test "drop work" do
      {:ok, pid} = Solution4350.start_link(%{test: "value"})

      assert Solution4350.drop(:some) == :ok
      assert Solution4350.current_state() == %{test: "value"}
      assert Solution4350.drop(:test) == :ok
      assert Solution4350.current_state() == %{}
      Process.exit(pid, :normal)
    end
  end

  describe "42/50 process registration" do
    test "list_registered work" do
      {:ok, _} = ProcessRegister.start_link()

      assert ProcessRegister.list_registered() == %{}
    end

    test "add work" do
      {:ok, _} = ProcessRegister.start_link()

      process = spawn(fn -> Process.sleep(:timer.seconds(10)) end)

      assert ProcessRegister.add(process, :some_process) == :ok
      assert %{some_process: ^process} = ProcessRegister.list_registered()

      second_process = spawn(fn -> Process.sleep(:timer.seconds(10)) end)

      assert ProcessRegister.add(second_process, :other_process) == :ok

      assert %{some_process: ^process, other_process: ^second_process} =
               ProcessRegister.list_registered()

      dead_process = spawn(fn -> 2 + 2 end)

      assert ProcessRegister.add(dead_process, :dead) == :ok

      assert %{some_process: ^process, other_process: ^second_process} =
               ProcessRegister.list_registered()
    end

    test "drop work" do
      {:ok, _} = ProcessRegister.start_link()

      process = spawn(fn -> Process.sleep(:timer.seconds(10)) end)

      ProcessRegister.add(process, :new_process)
      assert ProcessRegister.drop(:new_process) == :ok
      assert ProcessRegister.list_registered() == %{}

      assert ProcessRegister.drop(:not_existing_process) == :ok
    end
  end

  describe "41/50 incrementor code unchanged" do
    test "current_value work" do
      Incrementor.start_link()

      assert Incrementor.current_value() == 0
    end

    test "run work" do
      Incrementor.start_link()

      Incrementor.run()
      assert Incrementor.current_value() == 1

      Incrementor.run()
      assert Incrementor.current_value() == 2
    end
  end

  describe "41/50 decrementor code unchanged" do
    test "current_value work" do
      Decrementor.start_link()

      assert Decrementor.current_value() == 0
    end

    test "run work" do
      Decrementor.start_link()

      Decrementor.run()
      assert Decrementor.current_value() == -1

      Decrementor.run()
      assert Decrementor.current_value() == -2
    end
  end

  describe "41/50 solution supervisor work" do
    test "initialization work" do
      {:ok, pid} = Solution4150.start_link()
      # IO.inspect(pid)
      # dbg(Supervisor.which_children(pid))

      assert [
               {Decrementor, _, :worker, [Decrementor]},
               {Incrementor, _, :worker, [Incrementor]}
             ] = Supervisor.which_children(pid)

      assert Supervisor.count_children(pid) == %{
               active: 2,
               workers: 2,
               supervisors: 0,
               specs: 2
             }

      # assert Solution4150.150.term_childs() == :ok
    end

    test "restart straregy" do
      {:ok, pid} = Solution4150.start_link()

      Decrementor.run()
      assert Decrementor.current_value() == -1

      Incrementor.run()
      assert Incrementor.current_value() == 1

      Process.exit(Process.whereis(Decrementor), :kill)
      Supervisor.restart_child(pid, Process.whereis(Decrementor))

      assert Supervisor.count_children(pid) == %{
               active: 2,
               workers: 2,
               supervisors: 0,
               specs: 2
             }

      assert Decrementor.current_value() == 0
      assert Incrementor.current_value() == 1

      Process.exit(Process.whereis(Incrementor), :kill)
      Supervisor.restart_child(pid, Process.whereis(Incrementor))

      assert Supervisor.count_children(pid) == %{
               active: 2,
               workers: 2,
               supervisors: 0,
               specs: 2
             }

      assert Decrementor.current_value() == 0
      assert Incrementor.current_value() == 0
    end
  end

  describe "40/50 calculator code unchanged" do
    test "adding" do
      assert Calculator.exec(:+, 2, 3) == 5
      assert Calculator.exec(:+, 10, 20) == 30
    end

    test "subtraction" do
      assert Calculator.exec(:-, 2, 3) == -1
      assert Calculator.exec(:-, 10, 20) == -10
    end

    test "multiply" do
      assert Calculator.exec(:*, 2, 3) == 6
      assert Calculator.exec(:*, 10, 20) == 200
    end

    test "division" do
      assert Calculator.exec(:/, 2, 3) == 0
      assert Calculator.exec(:/, 20, 10) == 2
    end

    test "accumulator agent" do
      Accumulator.start_link(0)

      Accumulator.add(10)
      assert Accumulator.current() == 10
      Accumulator.add(3)
      assert Accumulator.current() == 13

      Accumulator.mul(10)
      assert Accumulator.current() == 130
      Accumulator.mul(3)
      assert Accumulator.current() == 390

      Accumulator.sub(10)
      assert Accumulator.current() == 380
      Accumulator.sub(3)
      assert Accumulator.current() == 377

      Accumulator.div(10)
      assert Accumulator.current() == 37
      Accumulator.div(3)
      assert Accumulator.current() == 12

      Accumulator.reset()
      assert Accumulator.current() == 0
      assert Agent.stop(Accumulator) == :ok
    end
  end

  test "39/50 foobar supervisor work" do
    result = supervise_foobar(80)

    assert result ==
             "Bar Foo Foo Bar Foo FooBar Foo Bar Foo Foo Bar"

    assert Enum.count(String.split(result)) == 11

    result = supervise_foobar(1)
    assert Enum.count(String.split(result)) == 47

    assert result ==
             "Foo Bar Foo Foo Bar Foo FooBar Foo Bar Foo Foo Bar Foo FooBar Foo Bar Foo Foo Bar Foo FooBar Foo Bar Foo Foo Bar Foo FooBar Foo Bar Foo Foo Bar Foo FooBar Foo Bar Foo Foo Bar Foo FooBar Foo Bar Foo Foo Bar"

    assert supervise_foobar(101) == ""
    assert supervise_foobar(-123) == ""
    assert supervise_foobar(0) == ""
  end

  describe "38/50 cache server work" do
    test "put" do
      parent = self()
      cache_server = spawn(fn -> CacheServer.init(parent) end)

      send(cache_server, {:put, {:hello, "world"}})
      assert_receive({:ok, "world"})
      assert Process.alive?(cache_server)

      send(cache_server, {:put, {:key, "value"}})
      assert_receive({:ok, "value"})
      assert Process.alive?(cache_server)
    end

    test "get" do
      parent = self()
      cache_server = spawn(fn -> CacheServer.init(parent) end)
      send(cache_server, {:put, {:hello, "world"}})

      send(cache_server, {:get, {:hello}})
      assert_receive({:ok, "world"})
      assert Process.alive?(cache_server)

      send(cache_server, {:get, {:some}})
      assert_receive({:error, :not_found})
      assert Process.alive?(cache_server)
    end

    test "drop" do
      parent = self()
      cache_server = spawn(fn -> CacheServer.init(parent) end)
      send(cache_server, {:put, {:hello, "world"}})

      send(cache_server, {:drop, {:hello}})
      assert_receive({:ok, :hello})
      assert Process.alive?(cache_server)

      send(cache_server, {:drop, {:some}})
      assert_receive({:ok, :some})
      assert Process.alive?(cache_server)
    end

    test "exit" do
      parent = self()
      cache_server = spawn(fn -> CacheServer.init(parent) end)

      send(cache_server, {:exit})
      assert_receive({:ok, :exited})
      refute Process.alive?(cache_server)
    end

    test "unexpected input" do
      parent = self()
      cache_server = spawn(fn -> CacheServer.init(parent) end)

      send(cache_server, {:something, {1, 2, 3}})
      assert_receive({:error, :unrecognized_operation})
      assert Process.alive?(cache_server)

      send(cache_server, :boom)
      assert_receive({:error, :unrecognized_operation})
      assert Process.alive?(cache_server)
    end
  end

  test "37/50 calculator process work" do
    parent = self()
    calculator = spawn(fn -> calculate(parent) end)

    send(calculator, {:+, [2, 5]})
    assert_receive({:ok, 7})
    assert Process.alive?(calculator)

    send(calculator, {:*, [2, 5]})
    assert_receive({:ok, 10})
    assert Process.alive?(calculator)

    send(calculator, {:-, [2, 5]})
    assert_receive({:ok, -3})
    assert Process.alive?(calculator)

    send(calculator, {:exit})
    assert_receive({:ok, :exited})
    refute Process.alive?(calculator)
  end

  # 36/50

  test "36/50 run_in_process work" do
    assert run_in_process(fn -> 2 + 2 end) |> is_pid()
    assert run_in_process(fn -> "hello world" end) |> is_pid()
  end

  # 35/50
  test "35/50 with" do
    assert validate("some") == {:ok, "some"}
    assert validate("hello!!") == {:ok, "hello!!"}
    assert validate(1) == {:error, :not_binary}
    assert validate("a") == {:error, :too_short}
    assert validate("hello, world!") == {:error, :too_long}
  end

  # 34/50
  test "34/50 compare" do
    assert compare(2, 3) == {:ok, :less}
    assert compare(3, 3) == {:ok, :equal}
    assert compare(4, 3) == {:ok, :greater}
    assert compare("", 3) == {:error, :not_number}
    assert compare(2, []) == {:error, :not_number}
  end

  # 33/50
  test "33/50 my_div work" do
    assert_raise(ArgumentError, "Divide 10 by zero is prohibited!", fn ->
      my_div(10, 0)
    end)

    assert_raise(ArgumentError, "Divide 128 by zero is prohibited!", fn ->
      my_div(128, 0)
    end)

    assert my_div(128, 2) == 64
    assert my_div(0, 2) == 0
  end

  # 32/50
  test "32/50 protocols common" do
    assert Teller.impl_for(%Human{}) == Teller.Human
    assert Teller.say_something(%Human{name: "John"}) == "Hello, world!"
    assert Teller.impl_for(%Dog{}) == Teller.Dog
    assert Teller.say_something(%Dog{name: "Barkinson"}) == "Bark, world!"
    assert Teller.impl_for(%Cat{}) == Teller.Cat
    assert Teller.say_something(%Cat{name: "Meowington"}) == "Meow, world!"
    assert Teller.impl_for(%Robot{}) == Teller.Any
    assert Teller.say_something(%Robot{name: "Roberto"}) == "World!"
  end

  # 31/50
  test "31/50 protocols" do
    assert Teller.say_something(%Human{name: "John"}) == "Hello, world!"
    assert Teller.say_something(%Dog{name: "Barkinson"}) == "Bark, world!"
    assert Teller.say_something(%Cat{name: "Meowington"}) == "Meow, world!"
  end

  # 30/50
  describe "30/50 parse work" do
    test "with valid input" do
      text = "hello\nworld!"
      assert parse(text) == {:ok, ["hello", "world!"]}

      text = "some"
      assert parse(text) == {:ok, ["some"]}

      text =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer commodo condimentum nulla sed aliquet. Donec sit amet euismod nulla, sed aliquam lacus. Maecenas dignissim ante eu gravida pellentesque. Ut hendrerit tellus ut facilisis convallis. Mauris ultrices quam in lectus condimentum semper. Aenean mi lectus, ornare quis mauris ut, convallis imperdiet erat. Proin pharetra sapien mauris, quis faucibus purus malesuada vel. Fusce sagittis et nisl quis pharetra. Duis ut erat tincidunt enim porttitor pulvinar sed sit amet ligula.\nSuspendisse potenti. Proin vel massa quam. Etiam dapibus ex in tincidunt congue. Nullam lorem enim, mollis id volutpat suscipit, dapibus vel metus. Nulla eget metus enim. Duis faucibus urna turpis, vitae auctor turpis blandit a. Proin diam eros, tempor non lorem ut, placerat placerat massa. Integer sagittis dictum ex, vestibulum lacinia metus sagittis vitae. Praesent mollis nibh sed sollicitudin iaculis. Vestibulum condimentum ut metus ut dapibus. Donec ut felis rutrum, maximus arcu sed, semper libero. Cras hendrerit diam et auctor suscipit. Nam nec lobortis nisi. Fusce ligula augue, tempor bibendum ex volutpat, luctus volutpat leo. Sed eu pretium lectus, vitae vestibulum eros.\nSed suscipit lobortis dolor, eu ultricies purus volutpat eu. Integer luctus erat eu metus cursus, in porta ex ullamcorper. Morbi et urna eget lorem gravida maximus at quis mi. Etiam auctor ultricies nunc eu convallis."

      assert parse(text) ==
               {:ok,
                [
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer commodo condimentum nulla sed aliquet. Donec sit amet euismod nulla, sed aliquam lacus. Maecenas dignissim ante eu gravida pellentesque. Ut hendrerit tellus ut facilisis convallis. Mauris ultrices quam in lectus condimentum semper. Aenean mi lectus, ornare quis mauris ut, convallis imperdiet erat. Proin pharetra sapien mauris, quis faucibus purus malesuada vel. Fusce sagittis et nisl quis pharetra. Duis ut erat tincidunt enim porttitor pulvinar sed sit amet ligula.",
                  "Suspendisse potenti. Proin vel massa quam. Etiam dapibus ex in tincidunt congue. Nullam lorem enim, mollis id volutpat suscipit, dapibus vel metus. Nulla eget metus enim. Duis faucibus urna turpis, vitae auctor turpis blandit a. Proin diam eros, tempor non lorem ut, placerat placerat massa. Integer sagittis dictum ex, vestibulum lacinia metus sagittis vitae. Praesent mollis nibh sed sollicitudin iaculis. Vestibulum condimentum ut metus ut dapibus. Donec ut felis rutrum, maximus arcu sed, semper libero. Cras hendrerit diam et auctor suscipit. Nam nec lobortis nisi. Fusce ligula augue, tempor bibendum ex volutpat, luctus volutpat leo. Sed eu pretium lectus, vitae vestibulum eros.",
                  "Sed suscipit lobortis dolor, eu ultricies purus volutpat eu. Integer luctus erat eu metus cursus, in porta ex ullamcorper. Morbi et urna eget lorem gravida maximus at quis mi. Etiam auctor ultricies nunc eu convallis."
                ]}
    end

    test "with invalid input" do
      assert parse("") == {:error, :no_text}
    end
  end

  test "extensions work" do
    assert extensions() == [".txt"]
  end

  # 29/50
  describe "29/50 generate_pets work" do
    test "with valid input" do
      pets = generate_pets(3)

      assert is_list(pets)

      Enum.each(Enum.with_index(pets), fn {pet, index} ->
        assert is_struct(pet, Pet)
        assert pet.name == "Barkley #{index}"
      end)
    end

    test "with invalid input" do
      pets = generate_pets(-20)

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
