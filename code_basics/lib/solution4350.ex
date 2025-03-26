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

  @impl true
  def handle_call(:current_state, _from, state), do: {:reply, state, state}

  @impl true
  def handle_call(:reset, _from, _state), do: {:reply, :ok, %{}}

  @impl true
  def handle_call(msg, _, state), do: {:reply, {:error, "error for #{msg}"}, state}
end
