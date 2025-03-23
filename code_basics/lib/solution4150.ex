defmodule Solution4150 do
  use Supervisor

  def start_link(init_state \\ %{}) do
    Supervisor.start_link(__MODULE__, init_state, name: __MODULE__)
  end

  # def term_childs do
  #   Supervisor.which_children(__MODULE__)
  #   |> Enum.map(fn {_, pid, _, _} -> pid end)
  #   |> Enum.map(fn pid -> Supervisor.terminate_child(__MODULE__, pid) end)
  #
  #   :ok
  # end

  def init(_args) do
    children = [{Incrementor, 0}, {Decrementor, 0}]
    Supervisor.init(children, strategy: :one_for_one)
  end
end
