defmodule Solution do
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
