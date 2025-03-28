defmodule Solution4350 do
  use GenServer

  def start_link(initial_state \\ %{}) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  @impl true
  def init(initial_state) do
    {:ok, initial_state}
  end

  def current_state, do: GenServer.call(__MODULE__, :current_state)
  def reset, do: GenServer.call(__MODULE__, :reset)
  def has?(key), do: GenServer.call(__MODULE__, {:has, key})
  def add(key, value), do: GenServer.call(__MODULE__, {:add, key, value})
  def drop(key), do: GenServer.call(__MODULE__, {:drop, key})

  @impl true
  def handle_call(:current_state, _from, state), do: {:reply, state, state}

  @impl true
  def handle_call(:reset, _from, _state), do: {:reply, :ok, %{}}

  @impl true
  def handle_call({:has, key}, _from, state) do
    # IO.puts("state=#{inspect(state)} key=#{key}")
    {:reply, Map.has_key?(state, key), state}
  end

  @impl true
  def handle_call({:add, key, value}, _from, state) do
    # IO.puts("state=#{inspect(state)} key=#{key}")
    {:reply, :ok, Map.put(state, key, value)}
  end

  @impl true
  def handle_call({:drop, key}, _from, state) do
    # IO.puts("state=#{inspect(state)} key=#{key}")
    {:reply, :ok, Map.delete(state, key)}
  end

  @impl true
  def handle_call(msg, _, state), do: {:reply, {:error, "error for #{msg}"}, state}
end
