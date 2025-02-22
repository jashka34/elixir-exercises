defmodule Distance do
  def distanse(point1, point2) do
    {:point, x1, y1} = point1
    {:point, x2, y2} = point2

    (:math.pow(x2 - x1, 2) + :math.pow(y2 - y1, 2))
    |> :math.sqrt()
  end
end

ExUnit.start()

defmodule DistanceTest do
  use ExUnit.Case
  import Distance

  test "distanse test" do
    assert distanse({:point, 0, 0}, {:point, 0, 0}) == 0.00
    assert distanse({:point, 0, 0}, {:point, 0, 100}) == 100.00
    assert distanse({:point, 0, 0}, {:point, 3, 4}) == 5.00
  end
end
