defmodule Example.BenchmarkServer do
  require Logger
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__,:ok,opts)
  end

  def init(:ok) do
    state = HashDict.new
    state = HashDict.put(state,:count, 0)
    state = HashDict.put(state,:runs, [])
    {:ok, state }
  end
  
  def total_clock(server) do
    GenServer.call(server,{:total_clock})
  end

  def push_run(server,run) do
    GenServer.cast(server,{:push_run, run})
  end


  def average_cost_per_call(server) do
    GenServer.call(server,{:avg_cost_per_call})
  end

  def handle_call({:total_clock}, _from, state ) do
    {:reply, Enum.sum(HashDict.get(state,:runs)), state}
  end

  def handle_call({:avg_cost_per_call},_from, state ) do
    {:reply, (Enum.sum(HashDict.get(state,:runs)) / HashDict.get(state,:count)) , state}
  end



  def handle_cast({:push_run, run},state) do
    state = HashDict.put(state,:runs, [run|HashDict.get(state,:runs)])
    state = HashDict.put(state,:count ,HashDict.get(state,:count) + 1)
    {:noreply, state}
  end
end
