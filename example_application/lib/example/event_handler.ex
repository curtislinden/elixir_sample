defmodule Example.EventHandler do
  require Logger
  use GenEvent

  def start_link(opts \\ []) do
    {:ok, pid_event } = GenEvent.start_link(opts)
    GenEvent.add_mon_handler(pid_event, __MODULE__, [])
    {:ok, pid_event }
  end

#
# considered using the event handler to take notice of failed document push
# but have went with exit process solution for now ( I expect this to lose the document dispatch request)
#
  def handle_event(event = {:error_input_output_dispatch, document, error_count}, state) do
    Logger.info(":error_input_output_dispatch called")
    if error_count < 10 do
      Example.OutputServer.dispatch_output(Example.OutputServer,document, error_count)
    else
      :timer.sleep(5000)
      Example.OutputServer.dispatch_output(Example.OutputServer,document, error_count)
      # back pressure logic
      # output has failed to be sent  
    end
    {:ok, state}
  end

  def handle_event(event = {:processed_input, document},state) do
    Example.OutputServer.dispatch_output(Example.OutputServer,document)
    {:ok , state }
  end


end

