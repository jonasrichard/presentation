defmodule Holder do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: Holder)
  end

  def get_table() do
    GenServer.call(Holder, :get) 
  end

  def init(_) do
    table = :ets.new(:session_tab, [:public])
    {:ok, table}
  end

  def handle_call(:get, _from, table) do
    {:reply, table, table}
  end
  def handle_call(_request, _from, state) do
    {:reply, :ok, state}
  end
end
