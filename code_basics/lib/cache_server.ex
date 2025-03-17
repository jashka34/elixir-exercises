defmodule CacheServer do
  def init(pid, init_state \\ %{}) do
    process(pid, init_state)
  end

  defp process(pid, state) do
    receive do
      {:put, {key, value}} ->
        new_state = Map.put(state, key, value)
        send(pid, {:ok, value})
        process(pid, new_state)

      {:get, {key}} ->
        result =
          if Map.has_key?(state, key) do
            {:ok, Map.get(state, key)}
          else
            {:error, :not_found}
          end

        send(pid, result)
        process(pid, state)

      {:drop, {key}} ->
        new_state = Map.delete(state, key)
        send(pid, {:ok, key})
        process(pid, new_state)

      {:exit} ->
        send(pid, {:ok, :exited})

      _ ->
        send(pid, {:error, :unrecognized_operation})
        process(pid, state)
    end
  end
end
