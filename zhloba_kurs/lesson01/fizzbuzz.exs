defmodule FizzBuzz do
  @moduledoc """
  Module FizzBuzz simple game
  Suxx but fine
  """

  @doc "main() function go to main"
  def main() do
    IO.puts("Start")
    fizzbuzz(10)
  end

  @doc "fizzbuzz_100(number) repeat fizzbuzz from 1 to 100"
  def fizzbuzz_100 do
    Enum.map(1..100, &fizzbuzz/1)
  end

  @doc "fizzbuzz() will be write fine soon"
  def fizzbuzz(number) do
    div_by_3 = rem(number, 3) == 0
    div_by_5 = rem(number, 5) == 0
    # IO.puts("div_by_3: " <> to_string(div_by_3))
    cond do
      div_by_3 and div_by_5 -> "FizzBuzz"
      div_by_3 -> "Fizz"
      div_by_5 -> "Buzz"
      true -> to_string(number)
    end
  end
end

ExUnit.start()

defmodule FizzBuzzTest do
  use ExUnit.Case
  import FizzBuzz

  test "fizzbuzz" do
    assert fizzbuzz(1) == "1"
    assert fizzbuzz(2) == "2"
    assert fizzbuzz(3) == "Fizz"
    assert fizzbuzz(4) == "4"
    assert fizzbuzz(5) == "Buzz"
    assert fizzbuzz(15) == "FizzBuzz"
    assert fizzbuzz(16) == "16"
    assert fizzbuzz(18) == "Fizz"
    assert fizzbuzz(25) == "Buzz"
    assert fizzbuzz(70) == "Buzz"
    assert fizzbuzz(90) == "FizzBuzz"
  end

  test "fizzbuz_100" do
    result = fizzbuzz_100()
    assert Enum.take(result, 5) == ["1", "2", "Fizz", "4", "Buzz"]
    assert Enum.at(result, 16) == "17"
    assert Enum.at(result, 29) == "FizzBuzz"
    assert Enum.at(result, 31) == "32"
    assert Enum.at(result, 39) == "Buzz"
    assert Enum.at(result, 48) == "49"
    assert Enum.at(result, 89) == "FizzBuzz"
    assert Enum.at(result, 91) == "92"
  end
end
