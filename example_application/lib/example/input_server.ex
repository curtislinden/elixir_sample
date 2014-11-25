@docs """
  This module implements the GenServer behaviour and is used to process input and forwarding the result
  via a event.

  GenServer represents an OTP concept where the client implementation will be exectued on a node which is
  not nessisarily the same node that is actually running the server process.

  GenServer provides interface for syncronous calls or async calls.
  

"""
defmodule Example.InputServer do
  use GenServer

  @doc """ 
     start commerce engine
  """
  def start_link(event_manager, opts \\ []) do
    GenServer.start_link(__MODULE__, event_manager , opts)
  end



  @doc """
   transform an document into it's final state,
   including dispbursements and result queue configuration

   after this it is ready to be started
  """
  def process_input(server,document) do
    GenServer.cast(server, {:process_input_async, document})
  end

  def process_input_sync(server,document) do
    GenServer.call(server, {:process_input, document})
  end
  
  def call_count(server) do
    GenServer.call(server, {:call_count})
  end

  def init(events) do
    call_count = 0
    {:ok, %{call_count: call_count, events: events} }
  end

  def handle_call({:call_count},_from, state = %{call_count: call_count}) do
    {:reply, call_count, %{ state | call_count: call_count + 1}}
  end

  def handle_call({:process_input, document }, _from, state = %{call_count: call_count, events: event_manager}) do
    processed_input = Dict.put(document,:processed, true)
    GenEvent.notify(event_manager,{:processed_input, processed_input})
    {:reply, processed_input , %{state | call_count: call_count + 1 }}
  end

  def handle_cast({:process_input_async, document }, state = %{call_count: call_count, events: event_manager}) do
    # processing document updating metadatata , disbursments etc
    processed_input = Dict.put(document,:processed, true)
    GenEvent.notify(event_manager,{:processed_input, processed_input})

    {:noreply, %{state | call_count: call_count + 1 }}
  end
end
