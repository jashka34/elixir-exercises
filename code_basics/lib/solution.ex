defmodule Solution do
  # 27/50
  def generate(n) do
    []
  end

  # 26/50
  def fetch_gamers(employees) do
    # dbg(employees)
    lst =
      for %{name: name, status: :active, hobbies: hobbies} <- employees,
          Enum.any?(hobbies, &(&1.type == :gaming)),
          do: {name, Enum.find(hobbies, fn n -> n.type == :gaming end)}

    # dbg(lst)
    lst
  end

  # 25/50
  def max_delta([], []), do: 0

  def max_delta(l1, l2) do
    maxlen = max(length(l1), length(l2))

    0..(maxlen - 1)
    |> Enum.map(&[Enum.at(l1, &1), Enum.at(l2, &1)])
    |> Enum.reduce(0, fn [n1, n2], acc -> max(acc, abs(n1 - n2)) end)
  end

  # 24/50
  def inc_numbers(list) do
    list
    |> Enum.filter(fn x -> is_number(x) end)
    |> Enum.map(fn x -> x + 1 end)
  end

  # 23/50
  def zip([], []), do: []

  def zip(n1, n2) do
    maxlen = max(length(n1), length(n2))

    0..(maxlen - 1)
    |> Enum.map(fn i -> [Enum.at(n1, i), Enum.at(n2, i)] end)
  end

  # def zip(n1, n2) do
  #   z =
  #     &(0..(length(&1) - 1)
  #       |> Enum.map(fn x -> [Enum.at(&1, x), Enum.at(&2, x)] end))
  #
  #   cond do
  #     length(n1) == 0 and length(n2) == 0 ->
  #       []
  #
  #     length(n1) > length(n2) ->
  #       n22 = n2 ++ List.duplicate(nil, length(n1) - length(n2))
  #       # dbg(n22)
  #       z.(n1, n22)
  #
  #     length(n2) > length(n1) ->
  #       n11 = n1 ++ List.duplicate(nil, length(n2) - length(n1))
  #       # dbg(n11)
  #       z.(n11, n2)
  #
  #     true ->
  #       z.(n1, n2)
  #   end
  # end

  # 22/50 
  def calculate(op, a, b) do
    # fpls = fn x, y -> x + y end
    # fdif = fn x, y -> x - y end
    # fmul = fn x, y -> x * y end
    # fdiv = fn x, y -> x / y end
    # case op do
    #   "+" -> fpls.(a, b)
    #   "-" -> fdif.(a, b)
    #   "*" -> fmul.(a, b)
    #   "/" -> fdiv.(a, b)
    #   _ -> nil
    # end

    fzn = fn zn ->
      Map.get(%{"+" => &(&1 + &2), "-" => &(&1 - &2), "*" => &(&1 * &2), "/" => &(&1 / &2)}, zn)
    end

    fzn.(op).(a, b)
  end

  # 21/50 
  def encode(chlist, shift) do
    Enum.map(chlist, fn ch -> ch + shift end)
  end

  def decode(chlist, shift) do
    Enum.map(chlist, fn ch -> ch - shift end)
  end

  # 20/50
  def filter_by_age(users, max_age) do
    filter_by_age(users, max_age, [])
  end

  defp filter_by_age([], _, acc), do: Enum.reverse(acc)

  defp filter_by_age([user | users], max_age, acc) do
    {:user, _, _, age} = user
    # dbg(user)
    # dbg(users)
    # dbg(acc)

    if age > max_age do
      filter_by_age(users, max_age, [user | acc])
    else
      filter_by_age(users, max_age, acc)
    end
  end

  # 19/50
  # переделать на решение учителя, оно короче 
  def range(from, to) when from <= to do
    [from | range(from + 1, to)]
  end

  def range(_, _), do: []

  # моё решение "с ходу"
  # def range(from, to) do
  #   cond do
  #     from > to -> []
  #     from == to -> [from]
  #     true -> range(from, to - 1, [to])
  #   end
  # end
  #
  # def range(from, to, acc) do
  #   # dbg("----")
  #   # dbg(from)
  #   # dbg(to)
  #   # dbg(acc)
  #
  #   if from == to do
  #     [from | acc]
  #   else
  #     range(from, to - 1, [to | acc])
  #   end
  # end

  # 18/50
  def my_cool_string(s, n) do
    s |> String.trim() |> String.downcase() |> String.duplicate(n)
  end

  # 17/50
  def check_row({a, b, c}) do
    valid_cell = [:x, :o, :f]

    if a in valid_cell and b in valid_cell and c in valid_cell do
      # dbg("valid" <> inspect({a, b, c}))
      true
    else
      # dbg("NOT valid" <> inspect({a, b, c}))
      false
    end
  end

  def check_row(_) do
    # dbg("check_row FALSE!")
    false
  end

  def valid_game?({row1, row2, row3}) do
    check_row(row1) and
      check_row(row2) and
      check_row(row3)
  end

  def valid_game?(_) do
    false
  end

  def check_who_win(state) do
    case state do
      {{:x, :x, :x}, _, _} -> {:win, :x}
      {_, {:x, :x, :x}, _} -> {:win, :x}
      {_, _, {:x, :x, :x}} -> {:win, :x}
      {{:x, _, _}, {:x, _, _}, {:x, _, _}} -> {:win, :x}
      {{_, :x, _}, {_, :x, _}, {_, :x, _}} -> {:win, :x}
      {{_, _, :x}, {_, _, :x}, {_, _, :x}} -> {:win, :x}
      {{:x, _, _}, {_, :x, _}, {_, _, :x}} -> {:win, :x}
      {{_, _, :x}, {_, :x, _}, {:x, _, _}} -> {:win, :x}
      {{:o, :o, :o}, _, _} -> {:win, :o}
      {_, {:o, :o, :o}, _} -> {:win, :o}
      {_, _, {:o, :o, :o}} -> {:win, :o}
      {{:o, _, _}, {:o, _, _}, {:o, _, _}} -> {:win, :o}
      {{_, :o, _}, {_, :o, _}, {_, :o, _}} -> {:win, :o}
      {{_, _, :o}, {_, _, :o}, {_, _, :o}} -> {:win, :o}
      {{:o, _, _}, {_, :o, _}, {_, _, :o}} -> {:win, :o}
      {{_, _, :o}, {_, :o, _}, {:o, _, _}} -> {:win, :o}
      _ -> :no_win
    end
  end

  # решение учителя
  # def check_who_win({{c, c, c}, _, _}) when c != :f, do: {:win, c}
  # def check_who_win({_, {c, c, c}, _}) when c != :f, do: {:win, c}
  # def check_who_win({_, _, {c, c, c}}) when c != :f, do: {:win, c}
  # def check_who_win({{c, _, _}, {c, _, _}, {c, _, _}}) when c != :f, do: {:win, c}
  # def check_who_win({{_, c, _}, {_, c, _}, {_, c, _}}) when c != :f, do: {:win, c}
  # def check_who_win({{_, _, c}, {_, _, c}, {_, _, c}}) when c != :f, do: {:win, c}
  # def check_who_win({{c, _, _}, {_, c, _}, {_, _, c}}) when c != :f, do: {:win, c}
  # def check_who_win({{_, _, c}, {_, c, _}, {c, _, _}}) when c != :f, do: {:win, c}
  # def check_who_win(_), do: :no_win

  # 16/50
  def single_win?(a_win, b_win) do
    cond do
      a_win and not b_win ->
        true

      not a_win and b_win ->
        true

      true ->
        false
    end
  end

  def double_win?(a_win, b_win, c_win) do
    if a_win and b_win and not c_win do
      :ab
    else
      if a_win and not b_win and c_win do
        :ac
      else
        if not a_win and b_win and c_win do
          :bc
        else
          false
        end
      end
    end
  end

  # 15/50
  def join_game(player) do
    case player do
      {:user, _name, age, _role} when age >= 18 -> :ok
      {:user, _name, _age, :admin} -> :ok
      {:user, _name, _age, :moderator} -> :ok
      _ -> :error
    end
  end

  def move_allowed?(cur_color, figure) do
    case figure do
      {:pawn, color} when color == cur_color -> true
      {:rock, color} when color == cur_color -> true
      _ -> false
    end
  end

  # 14/50
  def get_values(d) do
    %{a: av} = d
    %{b: bv} = d
    {av, bv}
  end

  def get_value_by_key(d, k) do
    %{^k => v} = d
    v
  end

  # 13/50 
  def get_age(user) do
    {:user, _, age} = user
    age
  end

  def get_names(users) do
    Enum.map(users, fn {:user, name, _} -> name end)
  end

  # 12/50 
  def keys_sum(m, k1, k2) do
    (m[k1] || 0) + (m[k2] || 0)
    # Map.get(map, key1, 0) + Map.get(map, key2, 0)
  end

  def keys_product(m, k1, k2) do
    (m[k1] || 1) * (m[k2] || 1)
    # Map.get(map, key1, 1) * Map.get(map, key2, 1)
  end

  def copy_key(m1, m2, k, dv) do
    Map.put(m2, k, m1[k] || dv)
    # value = Map.get(from_map, key, default_value)
    # Map.put(to_map, key, value)
  end

  # 11/50
  def get_second_item(list) do
    [n1, n2 | _] = list
    n1 + n2
  end

  # 10/50
  def distance({:point, x1, y1}, {:point, x2, y2}) do
    x_dist = abs(x1 - x2)
    y_dist = abs(y1 - y2)
    :math.sqrt(:math.pow(x_dist, 2) + :math.pow(y_dist, 2))
  end

  def is_point_inside_circle(point, circle) do
    # {:point, x1, x2} = point
    {:circle, center, radius} = circle
    distance = distance(point, center)
    # IO.puts("distance " <> to_string(distance))
    distance < radius
  end

  def is_point_inside_rect(point, rect) do
    {:point, x, y} = point
    {:rect, {:point, lx, ty}, {:point, rx, by}} = rect
    x >= lx and x <= rx and y <= ty and y >= by
  end

  # 09/50
  def sigil_i(string, []), do: String.to_integer(string)
  def sigil_i(string, [?n]), do: -String.to_integer(string)

  # 08/50
  def hours_to_milliseconds(s) do
    :timer.seconds(s * 60 * 60)
  end

  # 07/50
  @number_attr 10
  @boolean_attr false
  @hello_world_attr "Hello, World!"
  def test do
    if @boolean_attr do
      @hello_world_attr <> to_string(@number_attr)
    end
  end

  # 06/50
  def any?(a, b, c, d) do
    a or b or c or d
  end

  def truthy?(a, b) do
    a && b
  end

  # 05/50
  def do_math(a, b) do
    IO.puts((a + b) / b)
    IO.puts(div(a, b))
    IO.puts(rem(b, a))
  end

  # 04/50
  def join_and_upcase(s1, s2) do
    String.trim(String.upcase(s1, :ascii)) <> " " <> String.trim(String.upcase(s2, :ascii))
  end
end
