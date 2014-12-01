defmodule Example.EventHandler do
@moduledoc """
 This module implements the behaviour GenEvent and is itself specified as as
monitored handler for the events that the GenEvent process receives.#

"""

  require Logger
  use GenEvent

  def start_link(opts \\ []) do
    {:ok, pid_event } = GenEvent.start_link(opts)
    GenEvent.add_mon_handler(pid_event, __MODULE__, [])
    {:ok, pid_event }
  end

@doc """
  Handle the event that there is a server connection error in the dispatch_output function
  by retrying.

  The retry will continue indefinatly, with a 5 second delay after 10 failures.

"""
  def handle_event(event = {:error_input_output_dispatch, document, error_count}, state) do
    Logger.info(":error_input_output_dispatch called")
    if error_count < 10 do
      Example.OutputServer.dispatch_output(Example.OutputServer,document, error_count)
    else
      # back pressure logic       
      # output has failed to be sent  
      :timer.sleep(5000)
      Example.OutputServer.dispatch_output(Example.OutputServer,document, error_count)
    end
    {:ok, state}
  end
  
  @doc """
      Handle the {:processed_input, document} event by forwarding the document to the
      OutputServer process's dispatch_output function.
  """
  def handle_event(event = {:processed_input, document},state) do
    Example.OutputServer.dispatch_output(Example.OutputServer,document)
    {:ok , state }
  end

end

