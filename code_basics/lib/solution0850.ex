defmodule Solution0850 do
  def hours_to_milliseconds(s) do
    :timer.seconds(s * 60 * 60)
  end
end
