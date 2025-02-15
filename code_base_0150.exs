# Определение модуля Solution
defmodule Solution do
  # Определение функции hello
  # Отступ 2 пробела
  def hello do
    # Вызов функции другого модуля
    # Отступ 2 пробела
    # В конце не нужна точка с запятой
    IO.puts("Hello, World!")
  end
end

Solution.hello()
